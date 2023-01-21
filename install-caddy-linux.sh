#!/bin/bash
## Install Caddy 2 Web Server Linux
## https://temelkuran.ist/caddy-server-2-php-fpm-installation-on-ubuntu-server-19-10/
## https://caddy.community/t/fastcgi-using-unix-socket-with-caddy-2/6376
## https://caddy.community/t/v2-subfolder-proxy-to-upstream-root/7095/7
## https://caddyserver.com/
# https://github.com/caddyserver/caddy

wget https://github.com/caddyserver/caddy/releases/download/v2.0.0/caddy_2.0.0_linux_amd64.tar.gz
tar -xvf caddy_2.0.0_linux_amd64.tar.gz
rm -f LICENSE README.md caddy_2.0.0_linux_amd64.tar.gz
mv caddy /usr/bin/

wget https://raw.githubusercontent.com/caddyserver/dist/master/init/caddy.service
sed -i "s|User=caddy|User=www-data|" caddy.service
sed -i "s|Group=caddy|Group=www-data|" caddy.service
mv caddy.service /etc/systemd/system/

mkdir -p  /etc/caddy/conf.d/

echo 'import /etc/caddy/conf.d/*.conf' >/etc/caddy/Caddyfile

echo ':80 {
	root  * /var/www/html
	file_server
}' > /etc/caddy/conf.d/webapp.conf


systemctl daemon-reload
systemctl enable caddy
systemctl start caddy
