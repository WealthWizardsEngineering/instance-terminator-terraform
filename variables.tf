variable "name" {
  description = "The name to use for the components that make up this module"
  default     = "instance_terminator"
}

variable "lambda_schedule" {
  description = "The schedule for running the Lambda"
  default     = "rate(1 day)"
}

variable "instance_terminator_version" {
  description = "The version of the instance terminator lambda"
  default     = "v0.0.3"
}

variable "download_url" {
  description = "The full url for the instance terminator zip file, used for testing"
  default     = ""
}