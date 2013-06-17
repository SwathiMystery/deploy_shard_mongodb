HOSTNAME_F=`hostname -f`
HOSTNAME=`hostname`
host_content="
127.0.0.1\tlocalhost\n\n
# The following lines are desirable for IPv6 capable hosts\n
::1 ip6-localhost ip6-loopback\n
fe00::0 ip6-localnet\n
ff00::0 ip6-mcastprefix\n
ff02::1 ip6-allnodes\n
ff02::2 ip6-allrouters\n
ff02::3 ip6-allhosts\n
# Added by cloud-init\n

127.0.1.1\t$HOSTNAME_F\t$HOSTNAME
"
echo -e $host_content>/tmp/hosts.txt

