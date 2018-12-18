package main

import (
	"fmt"
	"os"
	"os/exec"
	"runtime"
)

func main() {

	command := "cat test.txt"

	var cmdargs []string
	if runtime.GOOS == "windows" {
		cmdargs = []string{"cmd", "/C"}
	} else {
		cmdargs = []string{"sh", "-c"}
	}
	cmdargs = append(cmdargs, command)

	cmd := exec.Command(cmdargs[0], cmdargs[1:]...)

	//cmd.Env = os.Environ()
	cmd.Env = make([]string, 0)
	cmd.Env = append(cmd.Env, "PATH=/Library/Frameworks/Python.framework/Versions/3.6/bin:/Library/Frameworks/Python.framework/Versions/3.6/bin:/Library/Frameworks/Python.framework/Versions/3.6/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/opt/X11/bin:/Users/dirkavery/Library/Python/3.6/bin:/Users/dirkavery/Library/Python/2.7/bin:/usr/local/Cellar/go/1.11.2/libexec/bin")

	//cmd.Env = os.Environ()
	cmd.Env = make([]string, 0)
	cmd.Env = append(cmd.Env, "PATH=/Library/Frameworks/Python.framework/Versions/3.6/bin:/Library/Frameworks/Python.framework/Versions/3.6/bin:/Library/Frameworks/Python.framework/Versions/3.6/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/opt/X11/bin:/Users/dirkavery/Library/Python/3.6/bin:/Users/dirkavery/Library/Python/2.7/bin:/usr/local/Cellar/go/1.11.2/libexec/bin")
	for i, a := range cmd.Env {
		fmt.Printf("cmd.Env[%v]: %v\n", i, a)
	}

	for i, a := range cmd.Args {
		fmt.Printf("cmd.Args[%v]: %v\n", i, a)
	}

	fmt.Printf("cmd.Dir: %v\n", cmd.Dir)
	fmt.Printf("cmd.Path: %v\n", cmd.Path)

	// Setup the command
	cmd.Stderr = os.Stderr
	cmd.Stdout = os.Stdout

	err := cmd.Start()
	if err == nil {
		err = cmd.Wait()
	}

}
