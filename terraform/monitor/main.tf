terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
  api_key = "datadog_api_key"
  app_key = "datadog_app_key"
}

resource "datadog_monitor" "alert_sqs_qty_msgs" {
  name    = "Monitoring for # msgs on queue ${var.queue}"
  type    = "metric alert"
  message = "{{#is_alert}} # msgs on {{queuename}} is higher than ${var.threshold_critical}. Current value is {{ value }} {{/is_alert}}\n\n{{#is_recovery}} # msgs on queue {{queuename}} is back to normal. {{/is_recovery}}\n ${var.notify}"

  query = "max(last_5m):avg:aws.sqs.approximate_number_of_messages_visible{queuename:${var.queue}} >= ${var.threshold_critical}"

  monitor_thresholds {
    critical          = var.threshold_critical
    critical_recovery = var.threshold_critical_recovery
  }

  notify_no_data    = false
  renotify_interval = 60
}