Deploy Replicated Sharded MongoDB Cluster
============================================

This repository has a set of scripts and resources required for 
deploying MongoDB replicated sharded cluster on Amazon EC2 instances.


How does this help you?
-----------------------
These scripts help you 
- To start a sharded cluster with replicated sets as shards.
- To stop and restart the same cluster.
- Dynamically add shards/ replicated sets.
- Dynamically add config Servers (1 or 3 - production)
- Dynamically add mongos routers

You may then log in to mongos router and just add the shards 
and enable sharding database.


Requirements
------------

- Capistrano should be installed on the client, where we launch the 
  cluster from the script.
- Configure an AMI on AWS with mongodb installed. We will be 
  using these machines, to launch the sharded cluster. For more information
  on how-to, please refer the following link
  [ MongoDB - Amazon EC2 ] (http://docs.mongodb.org/ecosystem/platforms/amazon-ec2/)
- The .pem file on your client for connecting to the instances you launched, from
  the AMI configured with MongoDB installation earlier.
- Instance IDs from the AWS Console of the instances you launched.
- AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY


How to use?
-----------
### Convention followed

#### Replica sets/shards
- The no. of replica set to be launched will be in rsNames. 
  Ex: 3 replica sets = rs0 rs1 rs2. 
- Instance ID declaration names should also be rs0 rs1 rs2. 
  All the instance ID will be within rs0, rs1, rs2, which constitute one replica set,
  each bearing 3 members of mongod instances. 
- Next, the hostname declaration should start with the same as rs0names, rs1names, 
  rs2names. The hostnames, can vary though, but would be better convention wise - ie.
  rs0mc1 meaning, replicaset 0 machine 1 and so on.

#### Config Servers
- Declare the no of config servers to be launched with no_of_cs.
  In our case its gonna be 1. (Production: 3 and in general, it can be 
  either 1 or 3 and not in between, mongodb sharding doesn't work)
- Similar to rsNames, all the config server names will be in csNames. 
  The only difference being, config server is a single entity. ie. 1 config server = 1 instance,
  but 1 replica set = 3+ instances. The numbering is from 1,2...n
- Instance ID declaration names should also be cs1, cs2, cs3 ..  and 
  each image ID will be the value for them respectively. 
- Next, the hostname declaration should start with the same as cs1names,
  cs2names, cs3names. The hostnames, can vary though, but would be better 
  convention wise - ie. cs1 meaning, config server1 and so on.

#### Mongos Routers
 The convention followed is same as Config Servers.


### Cap file operations
The main user operations are boot, config and start

#### Operation : boot
<code>cd deploy</code>

<code>./shard boot</code>

Boot will start the instances if stopped.
Please make sure after the boot, all the instances are in the running state 
( Couple of times, it may not start as expected due to aws cmd line tools issues - such a case exits,
boot again with the same command )


#### Operation : config
<code>cd deploy</code>

<code>./shard config</code>

Config will help us to generate all the required files in the /tmp 
ie. ipaddresses of rs,cs and ms, hostnames, js files, replica set information and 
not the least capfiles. These capfiles are generated within the respective directory.
ie. rs0..n cs1..n ms1..n


#### Operation : start
<code>cd deploy</code>

<code>./shard start</code>

Start operation does various things on each type.
On Replicated Sets : It will upload files like js scripts for 
re-configuring the replica set, complete hostname file ( has all hostnames rs,cs, ms),
uploads the right configuration file for mongodb to start. So, basically it will upload 
all the above, upgrade the mongodb, start the mongodb servers, initiate the replica set 
and reconfigure the replica set with the right hostnames.

On Config servers : It will upload files for complete hostname, 
right configuration for mongodb to start. So, basically it will 
upload all and then start the servers.

On mongos routers : It will upload hostnames, config server information to append 
for the right mongos conf file, upload the upstart script and update the rc.d .
Basically, it will upload and restart the mongos router with the script uploaded.

You can operate on individual machines, with the help of capfiles generated within the directories.
list of cap files generated

<code>
$ ls
</code>

<code>
cs1  cs2  cs3  ms1  rs0  rs1  rs2  rs3  shard
</code>



#### Operation : stop
<code>cd deploy</code>

<code>./shard stop</code>

Will stop all the running instances in the cluster - mongos, replica-sets/ shards and config servers.
