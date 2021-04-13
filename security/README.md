# metasploit2-docker
Metasploitable 2 docker container build on top of the great 
[tleemcjr/metasploitable2 image](https://hub.docker.com/r/tleemcjr/metasploitable2)

*"The Metasploit Framework is the foundation on which the commercial products are built. It is an open source project that provides the infrastructure, content, and tools to perform penetration tests and extensive security auditing. "*
https://metasploit.help.rapid7.com/docs/getting-started

### how to run
```
#build image
docker build -t <image_name> .

#run container, -P publishes all exposed ports to ephemeral range
docker run -dit -P <image_name>

#to check port binding run port command
docker port <image_name>
```

## TODO: build image from a source code