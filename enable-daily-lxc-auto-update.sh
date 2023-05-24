echo '0 0     * * *   root    sudo apt-get update && sudo apt-get dist-upgrade -y >/dev/null 2>&1' | tee -a /etc/crontab
