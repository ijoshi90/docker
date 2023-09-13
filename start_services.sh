systemctl enable cron
service grafana-server start
service jenkins start

ps -ef | grep jenkins
ps -ef | grep grafana
