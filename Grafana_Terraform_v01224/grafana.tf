resource "grafana_folder" "collection" {
  title = var.graf_folder_title
}

resource "grafana_dashboard" "metrics" {
  config_json = file("dashboard_template.json")
  folder      = grafana_folder.collection.id
}

resource "grafana_data_source" "influxdb" {
  type          = "influxdb"
  name          = "InfluxDB"
  url           = var.influx_db_url
  username      = "admin"
  password      = var.influx_db_pass
  access_mode   = "direct"
  database_name = "telegraf"
}

resource "grafana_alert_notification" "slack" {
  name = "Devops-lab"
  type = "slack"

  settings = {
    slack       = var.slack_ch_url
    uploadImage = "false"
  }
}