#!/bin/bash
# Copyright (c) 2013 Swathi Venkatachala
 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
 
# ---------------------------END COPYRIGHT------------------------------------
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

