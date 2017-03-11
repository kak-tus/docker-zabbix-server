template {
  source = "/root/zabbix_server.conf.template"
  destination = "/usr/local/etc/zabbix_server.conf.d/zabbix_server.conf"
}

exec {
  command = "zabbix_server -c /etc/zabbix/zabbix_server.conf -f"
  splay = "60s"
}
