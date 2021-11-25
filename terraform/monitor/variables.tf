variable "queue" {
  type        = string
  description = "Your queue name"
}

variable "notify" {
  type        = string
  description = "Where to route alerts to. Will look something like @pagerduty-<service> or @slack-<channel> etc."
}

variable "threshold_critical" {
  description = "Number of messages when to alert."
  default     = 1
  validation {
    condition     = coalesce(var.threshold_critical, 0) >= 1
    error_message = "The threshold_critical must be between 1 and infinty."
  }
}

variable "threshold_critical_recovery" {
  description = "Number of messages when to consider it back to normal."
  default     = 0.9
  validation {
    condition     = coalesce(var.threshold_critical_recovery, 0) >= 0.1
    error_message = "The threshold_critical_recovery must be between 0.1 and < threshold_critical."
  }
}
