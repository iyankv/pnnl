apt-get update
apt-get -y install mysql-server
mysql_secure_installation
chown -R mysql:mysql /var/lib/mysql/
chmod -R 775 /var/lib/mysql/ 
apt-get -y install nginx php5 php5-fpm php5-cli php5-mysql php5-mcrypt 
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
cd /etc/nginx
wget https://raw.githubusercontent.com/iyankv/pnnl/master/conf/nginx.conf
cd /etc/nginx/conf.d
wget https://raw.githubusercontent.com/iyankv/pnnl/master/conf/vps.conf
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
useradd -m vps
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
service php5-fpm restart
service nginx restart
cd /home/vps/public_html
wget https://raw.githubusercontent.com/iyankv/pnnl/master/conf/pnnl.tar
tar -xvf pnnl.tar
rm pnnl.tar
mysql -u root -p
chmod 777 /home/vps/public_html/config 
chmod 777 /home/vps/public_html/config/config.ini 
chmod 777 /home/vps/public_html/config/route.ini
