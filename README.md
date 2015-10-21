# surfspots

This is a chef cookbook to load the chef-client, an Apache server, a SQL database, and a simple php page to a remote linux server node and serve data about different surf breaks.

## CentOS

This cookbook has been tested using a CentOS Linux server and will be installed on an Amazon EC2 instance so I can use it to serve data to my angular.js frontend and also use it to serve data to mobile devices.

## Security

The cookbook uses encrypted passwords and provides read-only access to users and read and write access to admins. It can be accessed through the external IP address through ssh or http