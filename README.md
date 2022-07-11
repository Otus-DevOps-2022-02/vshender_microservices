# vshender_microservices

vshender microservices repository


## Homework #16: docker-2

- Added a pre-commit hook.
- Added a Github PR template.
- Added Github actions.
- Installed Docker.
- Experimented with various Docker commands.

<details><summary>Details</summary>

Install a pre-commit hook:
```
$ vim .pre-commit-config.yaml
$ pre-commit install
pre-commit installed at .git/hooks/pre-commit
```

Check Docker:
```
$ docker version
Client:
 Cloud integration: v1.0.25
 Version:           20.10.16
 API version:       1.41
 Go version:        go1.17.10
 Git commit:        aa7e414
 Built:             Thu May 12 09:20:34 2022
 OS/Arch:           darwin/amd64
 Context:           default
 Experimental:      true

Server: Docker Desktop 4.9.1 (81317)
 Engine:
  Version:          20.10.16
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.17.10
  Git commit:       f756502
  Built:            Thu May 12 09:15:42 2022
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.4
  GitCommit:        212e8b6fa2f44b9c21b2798135fc6fb7c53efc16
 runc:
  Version:          1.1.1
  GitCommit:        v1.1.1-0-g52de29d
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

$ docker info
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc., v0.8.2)
  compose: Docker Compose (Docker Inc., v2.6.0)
  sbom: View the packaged-based Software Bill Of Materials (SBOM) for an image (Anchore Inc., 0.6.0)
  scan: Docker Scan (Docker Inc., v0.17.0)

Server:
 Containers: 1
  Running: 1
  Paused: 0
  Stopped: 0
 Images: 3
 Server Version: 20.10.16
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 io.containerd.runtime.v1.linux runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 212e8b6fa2f44b9c21b2798135fc6fb7c53efc16
 runc version: v1.1.1-0-g52de29d
 init version: de40ad0
 Security Options:
  seccomp
   Profile: default
  cgroupns
 Kernel Version: 5.10.104-linuxkit
 Operating System: Docker Desktop
 OSType: linux
 Architecture: x86_64
 CPUs: 8
 Total Memory: 7.773GiB
 Name: docker-desktop
 ID: GA3U:AGYV:U6MS:ZAEP:OXSE:43GB:MILL:SIL6:LDUZ:IGJF:7SMA:7FUC
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 HTTP Proxy: http.docker.internal:3128
 HTTPS Proxy: http.docker.internal:3128
 No Proxy: hubproxy.docker.internal
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  hubproxy.docker.internal:5000
  127.0.0.0/8
 Live Restore Enabled: false
```

Run a first Docker container:
```
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete
Digest: sha256:13e367d31ae85359f42d637adf6da428f76d75dc9afeb3c21faea0d976f5c651
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

$ docker ps -a
CONTAINER ID   IMAGE         COMMAND    CREATED              STATUS                          PORTS     NAMES
79cb0bad4865   hello-world   "/hello"   About a minute ago   Exited (0) About a minute ago             funny_davinci

$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
hello-world   latest    feb5d9fea6a5   9 months ago   13.3kB
```

Experimenting with the `run`, `start`, `attach`, and `exec` Docker commands:
```
$ docker run -it ubuntu:18.04 /bin/bash
Unable to find image 'ubuntu:18.04' locally
18.04: Pulling from library/ubuntu
09db6f815738: Pull complete
Digest: sha256:478caf1bec1afd54a58435ec681c8755883b7eb843a8630091890130b15a79af
Status: Downloaded newer image for ubuntu:18.04
root@f07a59f3e9a4:/# echo 'Hello world!' > /tmp/file

root@f07a59f3e9a4:/# exit
exit

$ docker run -it ubuntu:18.04 /bin/bash
root@07abba940540:/# cat /tmp/file
cat: /tmp/file: No such file or directory

root@07abba940540:/# exit
exit

$ docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.CreatedAt}}\t{{.Names}}"
CONTAINER ID   IMAGE          CREATED AT                       NAMES
07abba940540   ubuntu:18.04   2022-07-05 23:57:16 +0100 WEST   keen_bhabha
f07a59f3e9a4   ubuntu:18.04   2022-07-05 23:56:52 +0100 WEST   serene_wilbur
79cb0bad4865   hello-world    2022-07-05 23:54:42 +0100 WEST   funny_davinci

$ docker ps -a
CONTAINER ID   IMAGE          COMMAND       CREATED         STATUS                     PORTS     NAMES
07abba940540   ubuntu:18.04   "/bin/bash"   3 minutes ago   Exited (1) 3 minutes ago             keen_bhabha
f07a59f3e9a4   ubuntu:18.04   "/bin/bash"   4 minutes ago   Exited (1) 4 minutes ago             serene_wilbur
79cb0bad4865   hello-world    "/hello"      6 minutes ago   Exited (0) 6 minutes ago             funny_davinci

$ docker start f07a59f3e9a4
f07a59f3e9a4

$ docker attach f07a59f3e9a4
root@f07a59f3e9a4:/# cat /tmp/file
Hello world!

root@f07a59f3e9a4:/# read escape sequence    # Ctrl-p Ctrl-q

$ docker ps -a
CONTAINER ID   IMAGE          COMMAND       CREATED         STATUS                     PORTS     NAMES
07abba940540   ubuntu:18.04   "/bin/bash"   3 minutes ago   Exited (1) 3 minutes ago             keen_bhabha
f07a59f3e9a4   ubuntu:18.04   "/bin/bash"   4 minutes ago   Up 27 seconds                        serene_wilbur
79cb0bad4865   hello-world    "/hello"      6 minutes ago   Exited (0) 6 minutes ago             funny_davinci

$ docker exec -it f07a59f3e9a4 bash
root@f07a59f3e9a4:/# ps afx
  PID TTY      STAT   TIME COMMAND
   12 pts/1    Ss     0:00 bash
   23 pts/1    R+     0:00  \_ ps afx
    1 pts/0    Ss+    0:00 /bin/bash

root@f07a59f3e9a4:/# exit
exit
```

Experimenting with the `commit` Docker command:
```
$ docker commit f07a59f3e9a4 vshender/ubuntu-tmp-file
sha256:2081712dd4de76fff23063e05869d96e288ce0be074b0840411c3636f7501e03

$ docker images
REPOSITORY                 TAG       IMAGE ID       CREATED         SIZE
vshender/ubuntu-tmp-file   latest    2081712dd4de   3 seconds ago   63.1MB
ubuntu                     18.04     ad080923604a   4 weeks ago     63.1MB
hello-world                latest    feb5d9fea6a5   9 months ago    13.3kB
```

Examine output of the `inspect` Docker command:
```
$ docker inspect 2081712dd4de
...

$ docker inspect f07a59f3e9a4
...
```

(See [docker_inspect_image.log](docker-monolith/docker_inspect_image.log) and [docker_inspect_container.log](docker-monolith/docker_inspect_container.log)).

The output of `docker inspect` for container has the "State", "HostConfig", "LogPath", "Mounts", and "NetworkSettings" items containing information about a running container.

Experimenting with the `ps`, `images`, `system`, `kill`, `rm`, and `rmi` Docker commands:
```
$ docker ps -q
f07a59f3e9a4

$ docker kill $(docker ps -q)
f07a59f3e9a4

$ docker system df
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
Images          3         2         63.16MB   63.15MB (99%)
Containers      3         0         88B       88B (100%)
Local Volumes   0         0         0B        0B
Build Cache     18        0         18.06MB   18.06MB

$ docker rm $(docker ps -a -q)
07abba940540
f07a59f3e9a4
79cb0bad4865

$ docker images -q
2081712dd4de
ad080923604a
feb5d9fea6a5

$ docker rmi $(docker images -q)
Untagged: vshender/ubuntu-tmp-file:latest
Deleted: sha256:2081712dd4de76fff23063e05869d96e288ce0be074b0840411c3636f7501e03
Deleted: sha256:770eca87c93b88ac6bd2e1ff801b821adb9ed79801e5cf37abc64138aef01fef
Untagged: ubuntu:18.04
Untagged: ubuntu@sha256:478caf1bec1afd54a58435ec681c8755883b7eb843a8630091890130b15a79af
Deleted: sha256:ad080923604aa54962e903125cd9a860605c111bc45afc7d491cd8c77dccc13b
Deleted: sha256:95129a5fe07e89c1898dc40a027b291d5fe33a67b35a88f0f0eaf51ea691f0b5
Untagged: hello-world:latest
Untagged: hello-world@sha256:13e367d31ae85359f42d637adf6da428f76d75dc9afeb3c21faea0d976f5c651
Deleted: sha256:feb5d9fea6a5e9606aa995e879d862b825965ba48de054caab5ef356dc6b3412
Deleted: sha256:e07ee1baac5fae6a26f30cabfe54a36d3402f96afda318fe0a96cec4ca393359
```

</details>
