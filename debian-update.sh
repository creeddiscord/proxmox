cat <<EOF >/etc/apt/sources.list
deb http://ftp.debian.org/debian sid main contrib
deb http://ftp.debian.org/debian trixie-updates main contrib
deb http://security.debian.org/debian-security trixie-security main contrib
EOF
apt-get update && apt-get upgrade -y && apt-get autoremove -y && reboot
