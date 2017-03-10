# DEPRECATED

# docker-dd-agent-build-rpm-i386

This repo contains the Dockerfile used to build the Datadog Agent (https://github.com/DataDog/dd-agent).

The Datadog Agent is built using a Chef omnibus project (https://github.com/DataDog/dd-agent-omnibus) on CircleCi.

The base image of the container is a homemade i386 image of Centos 5.

You'll need:
```
VirtualBox (Last tested on 4.3.x)
Vagrant (Last tested on 1.7)
```

Then you can clone the repo and run:
```
vagrant up
```
