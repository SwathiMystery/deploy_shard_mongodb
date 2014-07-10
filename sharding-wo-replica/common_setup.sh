echo "* soft nofile 64000
* hard nofile 64000
* soft nproc 32000
* hard nproc 32000 " >> /etc/security/limits.conf
echo "* soft nproc 32000
* hard nproc 32000 " >> /etc/security/limits.d/90-nproc.conf
