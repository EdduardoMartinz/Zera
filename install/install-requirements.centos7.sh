#dhclient
if [[ $PWD != */Zera/install ]]; then
    echo "Please, install from Zera/install directory"
    exit 1
fi
cd ..
yum update -y
yum install httpd -y
yum install mariadb-server mariadb -y
yum groupinstall "Development tools" -y
yum install 'perl(Template)' -y
yum install 'perl(JSON)' -y
yum install 'perl(Switch)' -y
#yum install git -y
#git clone https://github.com/Alt180/Zera.git
#cd Zera
systemctl start httpd.service
systemctl enable httpd.service
systemctl start mariadb
systemctl enable mariadb
sed -i 's/enforcing/disabled/g' /etc/selinux/config /etc/selinux/config
yes | cp /install/CentOS7/httpd.conf /etc/httpd/conf/httpd.conf
cp -r * /var/www/html
cd /var/www/html
mkdir -p data/img
yes | rm -r install
yes | rm -r testing
chown -R apache:apache *
chmod 755 index.pl
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
yum install perl-CPAN -y
(echo y;echo sudo;echo y; echo exit)|cpan
yes | cpan install CGI::Minimal Email::Sender:Simple MIME::Entity Apache::Session Number::Format JSON::XS Math::Round
systemctl restart httpd.service
reboot
