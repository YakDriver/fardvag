package main

import (
	"bytes"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"os/exec"
	"runtime"
	"strings"
	"time"
)

func main() {
	p := &ProcessProvider{
		Process:    "echo 5",
		MaxBufSize: 200,
		Timeout:    1000,
	}
	out, err := p.ExecuteCredentialProcess()
	if err != nil {
		fmt.Printf("error %v\n", err)
	} else {
		fmt.Printf("got from process: %v", string(out))
	}
}

// LimitedBuffer is a buffer wrapper that only allows a max amount of data.
type LimitedBuffer struct {
	maxSize int
	buff    *bytes.Buffer
}

// Write to the LimitedBuffer
func (b *LimitedBuffer) Write(p []byte) (int, error) {
	if len(p)+b.buff.Len() > b.maxSize {
		return -1, fmt.Errorf("buffer size (%v) exceeded: %v", b.maxSize, len(p)+b.buff.Len())
	}
	b.buff.Write(p)
	return len(p), nil
}

// Bytes retrieves data from the LimitedBuffer
func (b *LimitedBuffer) Bytes() []byte {
	return b.buff.Bytes()
}

// NewBuffer creates a new limited buffer.
func NewBuffer(start, max int) *LimitedBuffer {
	return &LimitedBuffer{
		maxSize: max,
		buff:    bytes.NewBuffer(make([]byte, 0, start)),
	}
}

const (

	// DefaultInitialBufSize size for initial buffer.
	DefaultInitialBufSize = 200

	// DefaultMaxBufSize limits memory usage from growing to an enormous
	// amount due to a faulty process.
	DefaultMaxBufSize = 512

	// DefaultTimeout limits the time a process can run, in milliseconds.
	DefaultTimeout = 500
)

// ProcessProvider provides process
type ProcessProvider struct {

	// A string representing an os command that should return a JSON with
	// credential information.
	Process string

	// MaxBufSize limits memory usage from growing to an enormous
	// amount due to a faulty process.
	MaxBufSize int

	// Timeout limits the time a process can run, in milliseconds.
	Timeout int
}

// ExecuteCredentialProcess executes the `process` command on the OS and
// returns the results or an error.
func (p *ProcessProvider) ExecuteCredentialProcess() ([]byte, error) {

	command := strings.TrimSpace(p.Process)
	if command == "" {
		return nil, fmt.Errorf("process must be a non-empty string")
	}

	var cmdargs []string
	var env []string
	if runtime.GOOS == "windows" {
		if comspec, ok := os.LookupEnv("ComSpec"); ok {
			cmdargs = []string{comspec, "/C"}
		} else {
			cmdargs = []string{"cmd", "/C"}
			if _, ok := os.LookupEnv("PATH"); !ok {
				env = append(env, fmt.Sprintf("%s=%s", "PATH", "C:\\Windows\\system32"))
			}
		}

	} else {
		cmdargs = []string{"/bin/sh", "-c"}
		if _, ok := os.LookupEnv("PATH"); !ok {
			env = append(env, fmt.Sprintf("%s=%s", "PATH", "/bin"))
		}
	}
	cmdargs = append(cmdargs, command)

	var cmdEnv []string
	cmdEnv = os.Environ()
	cmdEnv = append(cmdEnv, env...)

	// Setup the reader that will read the output from the command.
	pr, pw, err := os.Pipe()
	if err != nil {
		return nil, fmt.Errorf("failed to initialize pipe for output: %s", err)
	}

	// Setup the command
	cmd := exec.Command(cmdargs[0], cmdargs[1:]...)
	cmd.Stderr = pw
	cmd.Stdout = pw
	cmd.Env = cmdEnv

	output := NewBuffer(DefaultInitialBufSize, p.MaxBufSize)

	var readErr error
	read := make(chan bool, 1)
	go func() {
		// Write everything we read from the pipe to the output buffer
		tee := io.TeeReader(pr, output)

		// blocks until the pipe is closed - pw.Close()
		_, readErr = ioutil.ReadAll(tee)

		if readErr != nil {
			read <- false
			return
		}
		read <- true
	}()

	var execErr error
	exec := make(chan bool, 1)
	go func() {
		defer pw.Close() // important!

		// Start the command
		execErr = cmd.Start()
		if execErr == nil {
			execErr = cmd.Wait()
		}

		if execErr != nil {
			exec <- false
			return
		}

		exec <- true
	}()

	finished := false
	for !finished {
		select {
		case readResult := <-read:
			if !readResult {
				return nil, readErr
			}
			finished = true
		case execResult := <-exec:
			if !execResult {
				return nil, execErr
			}
		case <-time.After(time.Duration(p.Timeout) * time.Millisecond):
			return nil, fmt.Errorf("process timed out")
		}
	}

	return output.Bytes(), nil
}
