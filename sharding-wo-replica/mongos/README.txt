Partition /data /log /journal
Install mongodb
Change ownership to mongo group name
Copy mongodb.conf - change config server IP and port in the file
Run it as $nohup mongos --config /etc/mongodb.conf &
