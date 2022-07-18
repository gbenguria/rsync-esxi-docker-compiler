# rsync-esxi-compiler
This proyect was created to allow the transfer of big files over unstable networks

## prerequsites

* operating system that support linux x86_64 docker containers i.e. ubuntu 20
* docker 
* bash
* ssh
* scp
* rsync

## usage
in order to generate the statically compiled rsync for esxi 7.0 do the following.

``` bash
cd this_repo
echo to create the image that compiles rsync statically
docker build . -t rsync-esxi-compiler
echo to start the container in order to be able to copy the rsync binary
docker run -d --name rsync-esxi-compiler rsync-esxi-compiler /bin/bash -c "while true; do sleep 30; done;"
docker cp rsync-esxi-compiler:/rsync/rsync ~/.
echo to check that effectivelly is a statically compiled binary
ldd ~/rsync
echo to copy to the target esxi in a folder that belongs to the path
chmod 555 ~/rsync
scp ~/rsync root@esxi1.somedomain:/bin/rsync
echo to use it to create send a file 
while ( ! rsync -av --progress --bwlimit=20480 --inplace --partial --append ubuntu-22.04-live-server-amd64.iso root@esxi1.somedomain:/targetfolder ); do sleep 10; done
```
