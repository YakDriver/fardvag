resource "aws_ssm_maintenance_window" "window" {
  name     = "maintenance-window"
  schedule = "cron(0 16 ? * TUE *)"
  duration = 3
  cutoff   = 1
}

resource "aws_ssm_maintenance_window_task" "task" {
  window_id        = "${aws_ssm_maintenance_window.window.id}"
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunShellScript"
  priority         = 1
  service_role_arn = "arn:aws:iam::701759196663:role/YakTest"
  max_concurrency  = "2"
  max_errors       = "1"

  targets {
    key    = "InstanceIds"
    values = ["i-0f492331f004719f0"]
  }

  task_parameters {
    name   = "commands"
    values = ["dir"]
  }
}
