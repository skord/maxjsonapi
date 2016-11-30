# maxjsonapi
This app provides a JSONAPI for MariaDB Maxscale. It also includes a Ember JS application that can use said API so you can have an easy way to interact with your Maxscale server while it's up and running.


### Current Status

Until Maxscale 2.1 is available, this only works against the develop branch of that project. Plans to support versions < 2.1 are not in the works. 


### TL;DR I just want to play with it. 

1. Install [consul-backinator](https://github.com/myENA/consul-backinator) from here.
2. ```git clone https://github.com/skord/docker-images.git``` or download a copy from the releases page (you're better off with the git clone).
3. ```cd docker-images/examples/mrm-compose```
4. ```chmod +x bootstrap.sh```
5. ```./bootstrap.sh```   
6. Go to http://localhost:18080. 

### Getting it

You can download [a tarball from the releases page](https://github.com/skord/maxjsonapi/releases) for linux-86_64 platforms or use the docker image [skord/maxmanage](https://hub.docker.com/r/skord/maxmanage/tags/) on docker hub. 

### Running it

There are two prerequisites to running the app.  

1. The app needs the environment variable MAXSCALE_MAXINFO_IP_PORT set or a flag set on the command line. The ip:port needs to be reachable. This means you need maxinfo enabled on your Maxscale server.
2. The app expects that maxadmin be in your path and can run without needing to enter credentials. This means you'll need a .maxadmin file in the home directory of the user running it. 

#### Running the tarball versions

1. Expand the tarball
2. cd to the directory that was created. 
3. Run ```./maxmanage --host=127.0.0.1:8003``` (assuming your maxinfo is running on 8003 of localhost).
4. The Ember app, Maxpanel, is now available on port 9292 of your server.
 
#### Running the Docker image against a non-docker Maxscale

The docker container already contains a version of maxadmin and a .maxadmin file, so all you need to do is:

 ```bash
 docker pull skord/maxmanage
 docker run -d --name maxmanage \
             -e MAXSCALE_MAXINFO_IP_PORT=10.190.0.3:8003 \
             -v /tmp/maxadmin.sock:/tmp/maxadmin/maxadmin.sock \
             skord/maxmanage
 ```

 The volume mount in the form of ```-v /tmp/maxadmin.sock:/tmp/maxadmin/maxadmin.sock``` means that ```/tmp/maxadmin.sock``` is where your maxadmin socket actually lives on the host machine and the ```/tmp/maxadmin/maxadmin.sock``` is where it's mounted in the container.

   