# About this Repo

This is the Git repo of a Docker image for b2. 

This will create a single container running Apache 1.3.42, PHP 4.4.9, and MySQL.

Override the following default envvars in your Dockerfile.

```
B2_SITEURL='http://dockerhost'
B2_PATH_SERVER='http://dockerhost'
B2_ADMIN_EMAIL='admin@example.com'
B2_DBNAME='b2'
B2_DBHOST='127.0.0.1'
B2_DBUSERNAME='root' 
B2_DBPASSWORD='' 
B2_FILEUPLOAD_REALPATH='/usr/local/apache/htdocs/images'
B2_FILEUPLOAD_URL='http://dockerhost/images'
```
