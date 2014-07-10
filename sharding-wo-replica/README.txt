 For shards : i2.2xlarge
 For Mongos and Config Server : m3.large
 
 Security groups : Please check security-groups/ directory

 Execution : Post-Launch
1. Run i2partition_setup.sh on shards
2. Run m3large_setup.sh on mongos and config server
3. Run common_setup.sh on all machines
4. Copy respective configuration files as per the directory convention 
 to the servers and make changes accordingly as mentioned in the README.txt
5. Start the shards and then the config server and then the mongos as
 mentioned in the README.txt
