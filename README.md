Deploying Replicated Sharded MongoDB Cluster
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


Demo
----






