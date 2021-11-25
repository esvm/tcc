terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
  api_key = "41428292bdf6a0bbfebc2b0213629546"
  app_key = "ced0d4c22be854fb8284b1031b1e1561f37fb05c"
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