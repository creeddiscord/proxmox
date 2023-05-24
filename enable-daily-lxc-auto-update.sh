echo '0 0     * * *   root    apt-get update && apt-get upgrade -y >/dev/null 2>&1' | tee -a /etc/crontab
