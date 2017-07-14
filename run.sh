#!/usr/bin/env bash
# Run the OpenDJ server
# The idea is to consolidate all of the writable DJ directories to
# a single instance directory root, and update DJ's instance.loc file to point to that root
# This allows us to to mount a data volume on that root which  gives us
# persistence across restarts of OpenDJ.
# For Docker - mount a data volume on /opt/opendj/instances/instance1.
# For Kubernetes mount a PV
# To "prime" the sytem the first time DJ is run, we copy in a skeleton
# DJ instance from the instances/template directory that was created in the Dockerfile

cd /opt/opendj


# Instance dir does not exist?
if [ ! -d ./data/config ] ; then
  echo "Instance data Directory is empty. Creating new DJ instance"

  BOOTSTRAP=${BOOTSTRAP:-/opt/opendj/bootstrap/setup.sh}

  echo "Running $BOOTSTRAP"
  $BOOTSTRAP

fi

# todo: Check /opt/opendj/data/config/buildinfo
# Run upgrade if the server is older


echo "Starting OpenDJ"

# todo: Test to see if it is already running
#./bin/start-ds --nodetach
#
#echo "********ANTES START-DS*********"
./bin/start-ds
echo "********DESPUES START-DS***************"
/opt/opendj/bin/ldapmodify -D "cn=Directory Manager" -w password -h localhost -f /opt/opendj/data/post/openam-changes.ldif
echo "************Despues LDIF mdoify**************"
#./bin/stop-ds
#./bin/start-ds --nodetach
tail -f /opt/opendj/data/logs/server.out
#tail-f op
