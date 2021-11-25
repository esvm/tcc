module "datadog_sqs_qty_msgs" {
  source = "./monitor"

  queue  = "tcc-esvm-ufpe-dlq.fifo" // Main Queue
  notify = "@esvm@cin.ufpe.br"      // Author Email

  threshold_critical          = 1
  threshold_critical_recovery = 0.9
}