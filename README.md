# vshender_microservices

vshender microservices repository


## Homework #16: docker-2

- Added a pre-commit hook.
- Added a Github PR template.
- Added Github actions.
- Installed Docker.
- Experimented with various Docker commands.
- Created a Docker machine on a Yandex.Cloud VM.
- Built the application image and ran it.
- Pushed the application image to DockerHub.
- Implemented the application deployment.

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

Create a Docker machine on a Yandex.Cloud VM:
```
$ yc compute instance create \
  --name docker-host \
  --zone ru-central1-a \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1804-lts,size=15 \
  --ssh-key ~/.ssh/appuser.pub
done (36s)
id: fhmbrm0559oh9jgfsrds
folder_id: ...
created_at: "2022-07-11T14:42:35Z"
name: docker-host
zone_id: ru-central1-a
platform_id: standard-v2
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
boot_disk:
  mode: READ_WRITE
  device_name: fhm83c85c1oab87bpunn
  auto_delete: true
  disk_id: fhm83c85c1oab87bpunn
network_interfaces:
- index: "0"
  mac_address: d0:0d:bd:d8:05:2a
  subnet_id: e9bqom95bd1o3fkemarr
  primary_v4_address:
    address: 10.128.0.28
    one_to_one_nat:
      address: 62.84.114.61
      ip_version: IPV4
fqdn: fhmbrm0559oh9jgfsrds.auto.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}

$ docker-machine create \
  --driver generic \
  --generic-ip-address=62.84.114.61 \
  --generic-ssh-user yc-user \
  --generic-ssh-key ~/.ssh/appuser \
  docker-host
Creating CA: /Users/vshender/.docker/machine/certs/ca.pem
Creating client certificate: /Users/vshender/.docker/machine/certs/cert.pem
Running pre-create checks...
Creating machine...
(docker-host) Importing SSH key...
Waiting for machine to be running, this may take a few minutes...
Detecting operating system of created instance...
Waiting for SSH to be available...
Detecting the provisioner...
Provisioning with ubuntu(systemd)...
Installing Docker...
Copying certs to the local machine directory...
Copying certs to the remote machine...
Setting Docker configuration on the remote daemon...
Checking connection to Docker...
Docker is up and running!
To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env docker-host

$ docker-machine ls
NAME          ACTIVE   DRIVER    STATE     URL                       SWARM   DOCKER      ERRORS
docker-host   -        generic   Running   tcp://62.84.114.61:2376           v20.10.17

$ eval $(docker-machine env docker-host)
```

Compare the output of `htop`:
```
$ docker run --rm -ti tehbilly/htop
Unable to find image 'tehbilly/htop:latest' locally
latest: Pulling from tehbilly/htop
1eae7a7426b0: Pull complete
ac2ca7632b9e: Pull complete
Digest: sha256:2284dc3e689c1db92163af48b329b93d4de8c778d411c0e6e375430736e57117
Status: Downloaded newer image for tehbilly/htop:latest

$ docker run --rm --pid host -ti tehbilly/htop
```

`htop` from the last command displays all processes of the Docker machine's VM.


Build the application image and run it:
```
$ cd docker/docker-monolith

$ docker build -t reddit:latest .
Sending build context to Docker daemon  18.94kB
Step 1/7 : FROM ubuntu:16.04
16.04: Pulling from library/ubuntu
58690f9b18fc: Pull complete
b51569e7c507: Pull complete
da8ef40b9eca: Pull complete
fb15d46c38dc: Pull complete
Digest: sha256:20858ebbc96215d6c3c574f781133ebffdc7c18d98af4f294cc4c04871a6fe61
Status: Downloaded newer image for ubuntu:16.04
 ---> b6f507652425
Step 2/7 : RUN apt-get update
 ---> Running in 978554bf973d
...
Step 10/11 : RUN chmod 0777 /start.sh
 ---> Running in 638c267016a6
Removing intermediate container 638c267016a6
 ---> 9bd35c0d173f
Step 11/11 : CMD ["/start.sh"]
 ---> Running in 3eb83e42f4ea
Removing intermediate container 3eb83e42f4ea
 ---> ee329dbecf6e
Successfully built ee329dbecf6e
Successfully tagged reddit:latest

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them

$ docker images
REPOSITORY      TAG       IMAGE ID       CREATED         SIZE
reddit          latest    42a6b2e06960   5 seconds ago   676MB
ubuntu          18.04     ad080923604a   5 weeks ago     63.1MB
ubuntu          16.04     b6f507652425   10 months ago   135MB
tehbilly/htop   latest    4acd2b4de755   4 years ago     6.91MB

$ docker images -a
REPOSITORY      TAG       IMAGE ID       CREATED              SIZE
<none>          <none>    3d3d06782304   15 seconds ago       676MB
reddit          latest    42a6b2e06960   15 seconds ago       676MB
<none>          <none>    12ce4f78fa32   17 seconds ago       676MB
<none>          <none>    dc066c50f7bb   32 seconds ago       660MB
<none>          <none>    c99d719dd6ec   32 seconds ago       660MB
<none>          <none>    ec6dec58fbe7   33 seconds ago       660MB
<none>          <none>    2bdcf5ce9d40   33 seconds ago       660MB
<none>          <none>    9dc5324bcfce   37 seconds ago       660MB
<none>          <none>    251c190e19a9   About a minute ago   166MB
ubuntu          18.04     ad080923604a   5 weeks ago          63.1MB
ubuntu          16.04     b6f507652425   10 months ago        135MB
tehbilly/htop   latest    4acd2b4de755   4 years ago          6.91MB

$ docker run --name reddit -d --network=host reddit:latest
480ef124283b116af29f76e0adc167c89e5db8610bce3e8befafa7cd6bcd34a1
```

Open http://62.84.114.61:9292/ and check the application.

Push the application image to DockerHub:
```
$ docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: vshender
Password:
Login Succeeded

Logging in with your password grants your terminal complete access to your account.
For better security, log in with a limited-privilege personal access token. Learn more at https://docs.docker.com/go/access-tokens/

$ docker tag reddit:latest vshender/otus-reddit:1.0

$ docker push vshender/otus-reddit:1.0
The push refers to repository [docker.io/vshender/otus-reddit]
561d32163b5d: Pushed
4e468ef4e0d7: Pushed
e0b51e6e0b00: Pushed
c0e930ada599: Pushed
7e834663955a: Pushed
6abc2b3e7bb0: Pushed
7133d482fda6: Pushed
207ddfee0858: Pushed
1251204ef8fc: Pushed
47ef83afae74: Pushed
df54c846128d: Pushed
be96a3f634de: Pushed
1.0: digest: sha256:7b24122dde3b25e650192c096f228bd40136b24512db78444b254d8a794f2737 size: 2823

$ eval $(docker-machine env --unset)

$ docker run --name reddit -d -p 9292:9292 vshender/otus-reddit:1.0
Unable to find image 'vshender/otus-reddit:1.0' locally
1.0: Pulling from vshender/otus-reddit
58690f9b18fc: Pull complete
b51569e7c507: Pull complete
da8ef40b9eca: Pull complete
fb15d46c38dc: Pull complete
15ab9c91db51: Pull complete
2bf406696b28: Pull complete
ead2fc68327c: Pull complete
b4608768d268: Pull complete
081b5dd5e53c: Pull complete
d8be6b88f4d7: Pull complete
0712db74546f: Pull complete
9b5b1bbca7bd: Pull complete
Digest: sha256:7b24122dde3b25e650192c096f228bd40136b24512db78444b254d8a794f2737
Status: Downloaded newer image for vshender/otus-reddit:1.0
faacc704c59019ecff87bc57bb9ecc0dad9f8a14df6a9137548ae633e6efed9e
```

Open http://127.0.0.1:9292/ and test the application.

Destroy the Docker machine:
```
$ docker-machine rm docker-host
About to remove docker-host
WARNING: This action will delete both local reference and remote instance.
Are you sure? (y/n): y
Successfully removed docker-host

$ yc compute instance delete docker-host
done (15s)
```

Create infrastructure and deploy the application:
```
$ cd infra

$ packer build -var-file=packer/variables.json packer/docker-host.json
...

==> Wait completed after 5 minutes 17 seconds

==> Builds finished. The artifacts of successful builds are:
--> yandex: A disk image was created: docker-host-1658054613 (id: fd890m36h1ti7psoioh9) with family name docker-host

$ yc compute image list
+----------------------+----------------------------+-----------------+----------------------+--------+
|          ID          |            NAME            |     FAMILY      |     PRODUCT IDS      | STATUS |
+----------------------+----------------------------+-----------------+----------------------+--------+
...
| fd890m36h1ti7psoioh9 | docker-host-1658054613     | docker-host     | f2ep34rv24tdc64fekvu | READY  |
...
+----------------------+----------------------------+-----------------+----------------------+--------+

$ cd terraform

$ terraform init
Initializing the backend...

Initializing provider plugins...
- Finding yandex-cloud/yandex versions matching "~> 0.73.0"...
- Finding latest version of hashicorp/local...
- Installing yandex-cloud/yandex v0.73.0...
- Installed yandex-cloud/yandex v0.73.0 (unauthenticated)
- Installing hashicorp/local v2.2.3...
- Installed hashicorp/local v2.2.3 (unauthenticated)

...

$ terraform apply -auto-approve
...

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

app_vm_ips = [
  "51.250.91.72",
  "62.84.116.253",
]


$ cd ../ansible

$ ansible-playbook --skip-tags install_docker site.yml

PLAY [Install Docker] ********************************************************************************************

PLAY [Deploy reddit application] *********************************************************************************

TASK [Run reddit app container] **********************************************************************************
changed: [reddit-app-0]
changed: [reddit-app-1]

PLAY RECAP *******************************************************************************************************
reddit-app-0               : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
reddit-app-1               : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Open http://51.250.91.72:9292/ and http://62.84.116.253:9292/ and check the application.

Destroy the application's infrastructure:
```
$ cd ../terraform

$ terraform destroy -auto-approve
...

Destroy complete! Resources: 3 destroyed.
```

</details>


## Homework #17: docker-3

- Added the reddit application microservices code.
- Added Dockerfiles for the application images.
- Built the application images.
- Ran the application.
- Ran the application containers using different network aliases.
- Optimized the `comment` and `ui` images using an Ubuntu base image.
- Optimized the application images using an Alpine base image.
- Used a Docker volume to store MongoDB data.

<details><summary>Details</summary>

Prepare a Docker machine:
```
$ yc compute instance create \
  --name docker-host \
  --zone ru-central1-a \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1804-lts,size=15 \
  --ssh-key ~/.ssh/appuser.pub
...
      one_to_one_nat:
        address: 62.84.119.234
...

$ docker-machine create \
  --driver generic \
  --generic-ip-address=62.84.119.234 \
  --generic-ssh-user yc-user \
  --generic-ssh-key ~/.ssh/appuser \
  docker-host
...

$ eval $(docker-machine env docker-host)
```

Build the application images:
```
$ cd src

$ docker build -t vshender/post:1.0 -f Dockerfile.old ./post-py
...
Successfully built 8e9049ae34d6
Successfully tagged vshender/post:1.0

$ docker build -t vshender/comment:1.0 -f Dockerfile.ruby ./comment
...
Successfully built 6ba027cfeb81
Successfully tagged vshender/comment:1.0

$ docker build -t vshender/ui:1.0 -f Dockerfile.ruby ./ui
...
Successfully built fc53a1755fe2
Successfully tagged vshender/ui:1.0

$ docker images
REPOSITORY         TAG            IMAGE ID       CREATED              SIZE
vshender/ui        1.0            fc53a1755fe2   11 seconds ago       772MB
vshender/comment   1.0            6ba027cfeb81   About a minute ago   770MB
vshender/post      1.0            8e9049ae34d6   2 minutes ago        111MB
ruby               2.2            6c8e6f9667b2   4 years ago          715MB
python             3.6.0-alpine   cb178ebbf0f2   5 years ago          88.6MB
```

Run the application:
```
$ docker network create reddit
fd5feff84899137daa764e9cb2a3094a85ea6dace71dfb54718364ab1d1fb802

$ docker run -d \
    --network=reddit \
    --network-alias=post_db \
    --network-alias=comment_db \
    mongo:latest
Unable to find image 'mongo:latest' locally
latest: Pulling from library/mongo
...
Digest: sha256:82302b06360729842acd27ab8a91c90e244f17e464fcfd366b7427af652c5559
Status: Downloaded newer image for mongo:latest
bda52d0c6a16860162e6b2c281ce5e5d03a7d68368e7895484e1972a24f17095

$ docker run -d \
    --network=reddit \
    --network-alias=post \
    vshender/post:1.0
3523c4b38f96fe169ccbe7aab75e0cc3ff38d07edfb51b820b94a0770a7aca0a

$ docker run -d \
    --network=reddit \
    --network-alias=comment \
    vshender/comment:1.0
eaf56f450bf1cf781e1d6cae175918aee6e5f0e59844cdea5e961f2194aaf5a6

$ docker run -d \
    --network=reddit \
    -p 9292:9292 \
    vshender/ui:1.0
9ecc25b9e9830c1480279519f62818efc5c93eb13368b9fc2c6751cb6a8b0038
```

Open http://62.84.119.234:9292/ and test the application.

Run the application containers using different network aliases.
```
$ docker kill $(docker ps -q)
9ecc25b9e983
eaf56f450bf1
3523c4b38f96
bda52d0c6a16

$ docker run -d \
    --network=reddit \
    --network-alias=post_database \
    --network-alias=comment_database \
    mongo:latest
ccd828e9f1fcd9c1d01326ab5f78a73301fd9cd251d3b5dfa6c4571a1b31f7b0

$ docker run -d \
    --network=reddit \
    --network-alias=post_service \
    -e POST_DATABASE_HOST=post_database \
    vshender/post:1.0
33a8d0b88e3e96ca92159c865f157e3d9ade28619abce046bfe6d7dbb4cfa207

$ docker run -d \
    --network=reddit \
    --network-alias=comment_service \
    -e COMMENT_DATABASE_HOST=comment_database \
    vshender/comment:1.0
077c425687b739403cae90c0e8a3e4aef3e8675609369a53e08c5c52ed0b6c80

$ docker run -d \
    --network=reddit \
    -p 9292:9292 \
    -e POST_SERVICE_HOST=post_service \
    -e COMMENT_SERVICE_HOST=comment_service \
    vshender/ui:1.0
68af4302524ca413be790ba976d75363217f0c77c205869a0cbbab7138d6d3f9
```

Open http://62.84.119.234:9292/ and test the application.

Optimize the `comment` and `ui` images using an Ubuntu base image and examine the image sizes:
```
$ docker build -t vshender/comment:2.0 -f Dockerfile.ubuntu ./comment
...
Successfully built a77efba79646
Successfully tagged vshender/comment:2.0

$ docker build -t vshender/ui:2.0 -f Dockerfile.ubuntu ./ui
...
Successfully built 25e1f3b0b53e
Successfully tagged vshender/ui:2.0

$ docker images
REPOSITORY         TAG            IMAGE ID       CREATED          SIZE
vshender/ui        2.0            25e1f3b0b53e   10 seconds ago   410MB
vshender/comment   2.0            a77efba79646   46 seconds ago   407MB
vshender/ui        1.0            fc53a1755fe2   30 minutes ago   772MB
vshender/comment   1.0            6ba027cfeb81   31 minutes ago   770MB
vshender/post      1.0            8e9049ae34d6   32 minutes ago   111MB
mongo              latest         c8b57c4bf7e3   4 weeks ago      701MB
ubuntu             16.04          b6f507652425   10 months ago    135MB
ruby               2.2            6c8e6f9667b2   4 years ago      715MB
python             3.6.0-alpine   cb178ebbf0f2   5 years ago      88.6MB
```

Optimize the application images using an Alpine base image:
```
$ docker build -t vshender/post:2.0 ./post-py
...
Successfully built 9f025b407f1a
Successfully tagged vshender/post:2.0

$ docker build -t vshender/comment:3.0 ./comment
...
Successfully built 62859ed3f3bf
Successfully tagged vshender/comment:3.0

$ docker build -t vshender/ui:3.0 ./ui
...
Successfully built bb8fe4b4093a
Successfully tagged vshender/ui:3.0

$ docker images
REPOSITORY         TAG            IMAGE ID       CREATED          SIZE
vshender/ui        3.0            bb8fe4b4093a   9 seconds ago    71.6MB
vshender/comment   3.0            62859ed3f3bf   4 minutes ago    69.5MB
vshender/post      2.0            9f025b407f1a   5 minutes ago    107MB
vshender/ui        2.0            25e1f3b0b53e   25 minutes ago   410MB
vshender/comment   2.0            a77efba79646   26 minutes ago   407MB
vshender/ui        1.0            fc53a1755fe2   56 minutes ago   772MB
vhsender/comment   1.0            6ba027cfeb81   57 minutes ago   770MB
vshender/post      1.0            8e9049ae34d6   58 minutes ago   111MB
...
```

Use a Docker volume to store MongoDB data:
```
$ docker stop $(docker ps -q)
fdd93a8b764b
37fa1d2bbf3d
33a8d0b88e3e
ccd828e9f1fc

$ docker volume create reddit_db
reddit_db

$ docker run -d \
    --network=reddit \
    --network-alias=post_db \
    --network-alias=comment_db \
    -v reddit_db:/data/db \
    mongo:latest
94862b88ecc864b188468c65729f0c9843f0e7b6e5ba91c5ecbce42a44fe3512

$ docker run -d \
    --network=reddit \
    --network-alias=post \
    vshender/post:2.0
5129670cda53b9f1801c4a1af3e8a518cf74bf850562bcb074d866131f1b8e6b

$ docker run -d \
    --network=reddit \
    --network-alias=comment \
    vshender/comment:3.0
9ac3d835180e961cf2e58dc40f24a343f7ce4034273ca448107ea6f137de455e

$ docker run -d \
    --network=reddit \
    -p 9292:9292 \
    vshender/ui:3.0
393b0942a19c612998f50e8f5424be082c9fe0f51128748eaf3cc6bae0bb7c21
```

Open http://62.84.119.234:9292/ and create some posts and comments.

Restart a MongoDB container:
```
$ docker ps
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS                                       NAMES
...
94862b88ecc8   mongo:latest           "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   27017/tcp                                   serene_johnson

$ docker stop 94862b88ecc8
94862b88ecc8

$ docker run -d \
    --network=reddit \
    --network-alias=post_db \
    --network-alias=comment_db \
    -v reddit_db:/data/db \
    mongo:latest
155c291afafe61b76d70f89f3579f70217394f42f3344a25df0d17b7dec0f350
```

Open http://62.84.119.234:9292/ and verify that the created data still exists.

Stop the application containers:
```
$ docker stop $(docker ps -q)
155c291afafe
393b0942a19c
9ac3d835180e
5129670cda53
```

Remove the created bridge network:
```
$ docker network rm reddit
reddit
```

</details>


## Homework 18: docker-4

- Compared the `none` and `host` network drivers.
- Ran the application containers on two bridge networks so that the `ui` service didn't have access to the DB.
- Added a `docker-compose.yml` file to run the application.
- Modified `docker-compose.yml` to run the application containers on two bridge networks.
- Parameterized `docker-compose.yml`.
- Ran the application using the updated `docker-compose.yml` and specifying a project name.
- Added the `docker-compose.override.yml` file that allows you to edit the application code and apply changes without rebuilding images.

<details><summary>Details</summary>

Compare the `none` and `host` network drivers:
```
$ eval $(docker-machine env docker-host)

$ docker run --rm --network none joffotron/docker-net-tools -c ifconfig
Unable to find image 'joffotron/docker-net-tools:latest' locally
...
Status: Downloaded newer image for joffotron/docker-net-tools:latest
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

$ docker run --rm --network host joffotron/docker-net-tools -c ifconfig
br-fd5feff84899 Link encap:Ethernet  HWaddr 02:42:4B:75:B2:8B
          inet addr:172.18.0.1  Bcast:172.18.255.255  Mask:255.255.0.0
          inet6 addr: fe80::42:4bff:fe75:b28b%32622/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:281 errors:0 dropped:0 overruns:0 frame:0
          TX packets:353 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:185211 (180.8 KiB)  TX bytes:160578 (156.8 KiB)

docker0   Link encap:Ethernet  HWaddr 02:42:8A:EC:37:51
          inet addr:172.17.0.1  Bcast:172.17.255.255  Mask:255.255.0.0
          inet6 addr: fe80::42:8aff:feec:3751%32622/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:52155 errors:0 dropped:0 overruns:0 frame:0
          TX packets:85900 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:4111194 (3.9 MiB)  TX bytes:1236827460 (1.1 GiB)

eth0      Link encap:Ethernet  HWaddr D0:0D:17:28:49:B7
          inet addr:10.128.0.26  Bcast:10.128.0.255  Mask:255.255.255.0
          inet6 addr: fe80::d20d:17ff:fe28:49b7%32622/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:224231 errors:0 dropped:0 overruns:0 frame:0
          TX packets:119906 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:3215951264 (2.9 GiB)  TX bytes:11878584 (11.3 MiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1%32622/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:100284 errors:0 dropped:0 overruns:0 frame:0
          TX packets:100284 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:7388480 (7.0 MiB)  TX bytes:7388480 (7.0 MiB)

$ docker-machine ssh docker-host sudo apt install -y net-tools && ifconfig
...
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
        options=1203<RXCSUM,TXCSUM,TXSTATUS,SW_TIMESTAMP>
        inet 127.0.0.1 netmask 0xff000000
        inet6 ::1 prefixlen 128
        inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1
        nd6 options=201<PERFORMNUD,DAD>
gif0: flags=8010<POINTOPOINT,MULTICAST> mtu 1280
stf0: flags=0<> mtu 1280
XHC1: flags=0<> mtu 0
XHC0: flags=0<> mtu 0
XHC20: flags=0<> mtu 0
VHC128: flags=0<> mtu 0
en5: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        ...
ap1: flags=8802<BROADCAST,SIMPLEX,MULTICAST> mtu 1500
        ...
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        ...
awdl0: flags=8943<UP,BROADCAST,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
        ...
llw0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        ...
en1: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
        ...
en2: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
        ...
en3: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
        ...
en4: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
        ...
bridge0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        ...
utun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1380
        ...
utun1: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 2000
        ...
utun2: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 1000
        ...
en8: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        ...
```

Run the application containers on two bridge networks so that the `ui` service doesn't have access to the DB.
```
$ docker network create back_net --subnet=10.0.2.0/24
5f5f01466d0c881bed1f3c058ad049f3cc2a90aa09b8a6499c4da77fcf77c236

$ docker network create front_net --subnet=10.0.1.0/24
22bc170d24e9805cbdd8d7e6de6bea69f40529e901234d53df595910080ef173

$ docker network list
NETWORK ID     NAME        DRIVER    SCOPE
5f5f01466d0c   back_net    bridge    local
f580f42afc1e   bridge      bridge    local
22bc170d24e9   front_net   bridge    local
ede3e8bcd3df   host        host      local
6ac654ba85f4   none        null      local

$ docker run -d --network=front_net -p 9292:9292 --name ui vshender/ui:3.0
e2f912af502d56aa42a26623d1751c280999b9ee81b7c79d8a50c14822d1f81b

$ docker run -d --network=back_net --name comment vshender/comment:3.0
667d364af1a74e273785dbff6693cd87544c387dfd5bcecc827aaed4c8c9afc3

$ docker run -d --network=back_net --name post vshender/post:2.0
43fe9073a6bc21a267fe1aacf9092567e9f069057b62b409fae8ccd91e92fcd6

$ docker run -d --network=back_net --name mongo_db --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
e280830eabede0a4a81f0ecd265d27c24c8c9832dda83315d0c05148d89f4672

$ docker network connect front_net post

$ docker network connect front_net comment
```

Open http://62.84.119.234:9292/ and check the application.

Examine network on Docker machine:
```
$ docker-machine ssh docker-host
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 4.15.0-112-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
New release '20.04.4 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

yc-user@docker-host:~$ sudo apt update && sudo apt install bridge-utils
...

yc-user@docker-host:~$ sudo docker network ls
NETWORK ID     NAME        DRIVER    SCOPE
5f5f01466d0c   back_net    bridge    local
f580f42afc1e   bridge      bridge    local
22bc170d24e9   front_net   bridge    local
ede3e8bcd3df   host        host      local
6ac654ba85f4   none        null      local

yc-user@docker-host:~$ ifconfig | grep ^br
br-22bc170d24e9: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
br-5f5f01466d0c: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500

yc-user@docker-host:~$ brctl show br-22bc170d24e9
bridge name             bridge id               STP enabled     interfaces
br-22bc170d24e9         8000.024211a431d0       no              veth6437a35
                                                                vethf4ab308
                                                                vethf91e4b1

yc-user@docker-host:~$ brctl show br-5f5f01466d0c
bridge name             bridge id               STP enabled     interfaces
br-5f5f01466d0c         8000.024293451890       no              veth2ebcd2d
                                                                vetha5ab886
                                                                vetha6fc845

yc-user@docker-host:~$ sudo iptables -nL -t nat
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination
DOCKER     all  --  0.0.0.0/0            0.0.0.0/0            ADDRTYPE match dst-type LOCAL

Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
DOCKER     all  --  0.0.0.0/0           !127.0.0.0/8          ADDRTYPE match dst-type LOCAL

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination
MASQUERADE  all  --  10.0.1.0/24          0.0.0.0/0
MASQUERADE  all  --  10.0.2.0/24          0.0.0.0/0
MASQUERADE  all  --  172.17.0.0/16        0.0.0.0/0
MASQUERADE  tcp  --  10.0.1.2             10.0.1.2             tcp dpt:9292

Chain DOCKER (2 references)
target     prot opt source               destination
RETURN     all  --  0.0.0.0/0            0.0.0.0/0
RETURN     all  --  0.0.0.0/0            0.0.0.0/0
RETURN     all  --  0.0.0.0/0            0.0.0.0/0
DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:9292 to:10.0.1.2:9292

yc-user@docker-host:~$ ps -ef | grep docker-proxy
root     20259  3730  0 18:46 ?        00:00:00 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 9292 -container-ip 10.0.1.2 -container-port 9292
root     20266  3730  0 18:46 ?        00:00:00 /usr/bin/docker-proxy -proto tcp -host-ip :: -host-port 9292 -container-ip 10.0.1.2 -container-port 9292
yc-user  23759 22660  0 18:56 pts/0    00:00:00 grep --color=auto docker-proxy

yc-user@docker-host:~$ logout
```

Stop the application containers:
```
$ docker stop $(docker ps -q)
e280830eabed
43fe9073a6bc
667d364af1a7
e2f912af502d
```

Use the `docker-compose.yml` file to run the application:
```
$ cd src

$ export USERNAME=vshender

$ docker-compose up -d
Creating network "src_reddit" with the default driver
Creating volume "src_post_db" with default driver
Pulling db (mongo:3.2)...
...
Creating src_post_1    ... done
Creating src_comment_1 ... done
Creating src_ui_1      ... done
Creating src_db_1      ... done

$ docker-compose ps
    Name                  Command             State                    Ports
----------------------------------------------------------------------------------------------
src_comment_1   puma                          Up
src_db_1        docker-entrypoint.sh mongod   Up      27017/tcp
src_post_1      python3 post_app.py           Up
src_ui_1        puma                          Up      0.0.0.0:9292->9292/tcp,:::9292->9292/tcp
```

Open http://62.84.119.234:9292/ and check the application.

Shut down the application:
```
$ docker-compose down
Stopping src_comment_1 ... done
Stopping src_db_1      ... done
Stopping src_ui_1      ... done
Stopping src_post_1    ... done
Removing src_comment_1 ... done
Removing src_db_1      ... done
Removing src_ui_1      ... done
Removing src_post_1    ... done
Removing network src_reddit
```

Run the application using the updated `docker-compose.yml` and specifying a project name.
```
$ docker-compose -p reddit up -d
Creating network "reddit_back_net" with the default driver
Creating network "reddit_front_net" with the default driver
Creating reddit_comment_1 ... done
Creating reddit_db_1      ... done
Creating reddit_ui_1      ... done
Creating reddit_post_1    ... done
```

Open http://62.84.119.234:8000/ and check the application.

Shut down the application:
```
$ docker-compose -p reddit down
Stopping reddit_ui_1      ... done
Stopping reddit_post_1    ... done
Stopping reddit_db_1      ... done
Stopping reddit_comment_1 ... done
Removing reddit_ui_1      ... done
Removing reddit_post_1    ... done
Removing reddit_db_1      ... done
Removing reddit_comment_1 ... done
Removing network reddit_back_net
Removing network reddit_front_net
```

Destroy the Docker machine:
```
$ docker-machine rm docker-host
About to remove docker-host
WARNING: This action will delete both local reference and remote instance.
Are you sure? (y/n): y
Successfully removed docker-host

$ yc compute instance delete docker-host
done (15s)
```

</details>


## Homework #20: gitlab-ci-1

- Implemented Gitlab deployment.
- Added a pipeline definition.
- Started and registered a Gitlab runner.
- Added the application code to the repository.
- Added a unit test for the application.
- Defined the `review` stage and the `dev` environment.
- Defined the `staging` and the `production` stages.
- Restricted the `staging` and the `production` stages to run for tags only.
- Added dynamic environments for branches.
- Implemented the application container building.
- Implemented the application container testing.
- Implemented testing environment creation and the application deployment for review.
- Implemented GitLab runners creation.
- Configured GitLab integration with Slack.

<details><summary>Details</summary>

Deploy Gitlab:
```
$ cd gitlab-ci/gitlab/infra/terraform

$ terraform init
...

$ terraform apply -auto-approve
...

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

gitlab_external_ip = "84.201.130.130"

$ cd ../ansible

$ ansible-playbook playbooks/site.yml
...

TASK [Show Gitlab password] **************************************************************************************
ok: [gitlab] => {
    "msg": "Gitlab credentials for the first login: username: root, password: ..."
}

PLAY RECAP *******************************************************************************************************
gitlab                     : ok=8    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Configure Gitlab:
1. Open http://84.201.130.130/
2. Login using the provided credentials.
3. Go to "Edit profile" -> "Password" and change the password, as the file containing the default password will be deleted after 24 hours.
4. Go to "Menu" -> "Admin" -> "Settings" -> "General" -> "Sign-up restrictions" and disable sign-up.

Useful links:
- [GitLab Docker images](https://docs.gitlab.com/ee/install/docker.html)
- [community.docker.docker_container module --- manage docker containers](https://docs.ansible.com/ansible/latest/collections/community/docker/docker_container_module.html)

Configure a repository for the application:
1. Go to "+" -> "New group" and create a new private group named "homework".
2. Create a new project named "example".
3. Push the application repository:
```
$ git remote add gitlab http://84.201.130.130/homework/example.git

$ git push gitlab gitlab-ci-1
...
```

Go to "CI/CD" -> "Pipelines" and check that the pipeline status is "pending".

Go to "Settings" -> "CI/CD" -> "Runners" and get the runners registration token.

Start and register a Gitlab runner:
```
$ ssh -i ~/.ssh/appuser ubuntu@84.201.130.130
...
ubuntu@fhmojvm426geln1lnl5m:~$ sudo docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest
Unable to find image 'gitlab/gitlab-runner:latest' locally
latest: Pulling from gitlab/gitlab-runner
d7bfe07ed847: Already exists
fa6bd21be6f6: Pull complete
d4a2aca7780c: Pull complete
Digest: sha256:3c00590a96d46655560b6c19b898c2b70a87213b9de48364ae4d426861db807f
Status: Downloaded newer image for gitlab/gitlab-runner:latest
59bbae83e03c946cc004a82288865a6475252d4f8d3dfb50934ad86e57f5e3eb

ubuntu@fhmojvm426geln1lnl5m:~$ sudo docker exec -it gitlab-runner gitlab-runner register \
  --url http://84.201.130.130/ \
  --registration-token ... \
  --non-interactive \
  --locked=false \
  --name DockerRunner \
  --executor docker \
  --docker-image alpine:latest \
  --tag-list "linux,xenial,ubuntu,docker" \
  --run-untagged
Runtime platform                                    arch=amd64 os=linux pid=42 revision=32fc1585 version=15.2.1
Running in system-mode.

Registering runner... succeeded                     runner=GR1348941JkFNu6JQ
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!

Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml"

ubuntu@fhmojvm426geln1lnl5m:~$ exit
logout
```

Go to "CI/CD" -> "Pipelines" and check that the pipeline status is "passed".

Add the application code to the repository:
```
$ cd ../../../

$ git clone https://github.com/express42/reddit.git && rm -rf ./reddit/.git
...
```

Push the code to the Gitlab repository, then go to "Deployment" -> "Environments" and check environments.

Go to "Settings" -> "CI/CD" -> "Variables" and add the `DOCKER_HUB_LOGIN` and the `DOCKER_HUB_PASSWD` variables needed for the application image building.

Go to "Settigns" -> "CI/CD" -> "Runners" and remove the previously registered runner.

Register a GitLab runner to use the `docker` image and `privileged` mode in order to be able to build Docker images:
```
$ ssh -i ~/.ssh/appuser ubuntu@84.201.130.130
...
ubuntu@fhmojvm426geln1lnl5m:~$ sudo docker stop gitlab-runner
gitlab-runner

ubuntu@fhmojvm426geln1lnl5m:~$ sudo docker rm gitlab-runner
gitlab-runner

ubuntu@fhmojvm426geln1lnl5m:~$ sudo docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest
1cb8f35f7242658d717803861255ee59e949212cfdbe80e47c8cc04ec86434b0

ubuntu@fhmojvm426geln1lnl5m:~$ sudo docker exec -it gitlab-runner gitlab-runner register \
  --url http://84.201.130.130/ \
  --registration-token ... \
  --docker-privileged \
  --non-interactive \
  --locked=false \
  --name DockerRunner \
  --executor docker \
  --docker-image docker:19.03.1 \
  --tag-list "linux,xenial,ubuntu,docker" \
  --run-untagged
Runtime platform                                    arch=amd64 os=linux pid=29 revision=32fc1585 version=15.2.1
Running in system-mode.

Registering runner... succeeded                     runner=GR1348941JkFNu6JQ
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!

Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml"

ubuntu@fhmojvm426geln1lnl5m:~$ exit
logout
```

Push the code to the Gitlab repository, then go to Docker Hub and check the built application image.

Useful links:
- [Use Docker to build Docker images](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html#use-docker-in-docker)
- [Update: Changes to GitLab CI/CD and Docker in Docker with Docker 19.03](https://about.gitlab.com/blog/2019/07/31/docker-in-docker-with-docker-19-dot-03/)

Create a bucket for the terraform state storage:
```
$ cd gitlab-ci/gitlab/infra/terraform
$ terraform apply -auto-approve
...
```

Go to "Settings" -> "CI/CD" -> "Variables" and add the `YC_OAUTH_TOKEN`, `YC_CLOUD_ID`, `YC_FOLDER_ID`, `YC_SUBNET_ID`, `YC_STATE_BUCKET_ACCESS_KEY`, and `YC_STATE_BUCKET_SECRET_KEY` variables needed for testing environments creation.

Push a new branch to the Gitlab repository, then go to "Deployment" -> "Environments" and check the environment created for the branch.

Useful links:
- [Set dynamic environment URLs after a job finishes](https://docs.gitlab.com/ee/ci/environments/#set-dynamic-environment-urls-after-a-job-finishes)

Go to "Settigns" -> "CI/CD" -> "Runners" and remove the previously registered runner.

Stop the existing GitLab runner:
```
$ ssh -i ~/.ssh/appuser ubuntu@84.201.130.130
...
ubuntu@fhmojvm426geln1lnl5m:~$ sudo docker stop gitlab-runner
gitlab-runner

ubuntu@fhmojvm426geln1lnl5m:~$ sudo docker rm gitlab-runner
gitlab-runner

ubuntu@fhmojvm426geln1lnl5m:~$ exit
logout
```

Create and register new GitLab runners using Ansible playbook:
```
$ cd gitlab-ci/gitlab/infra/ansible

$ ansible-playbook playbooks/site.yml --extra-vars "runner_token=... runners_count=2" --tags create_runners
...
PLAY RECAP *******************************************************************************************************
gitlab                     : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Go to "Settings" -> "Integrations" -> "Slack notifications" and configure Slack integration.

You can check GitLab notifications [here](https://devops-team-otus.slack.com/archives/GSFU43CHG).

</details>


## Homework #22: monitoring-1

- Got acquainted with Prometheus.
- Built a Prometheus Docker image to monitor the application.
- Added Prometheus service to the `docker/docker-compose.yml` file.
- Added [node-exporter](https://github.com/prometheus/node_exporter) for host machine monitoring.
- Pushed the created application images to DockerHub.
- Implemented MongoDB monitoring using [mongodb-exporter](https://github.com/percona/mongodb_exporter).

<details><summary>Details</summary>

Create a Docker machine on a Yandex.Cloud VM:
```
$ yc compute instance create \
    --name docker-host \
    --zone ru-central1-a \
    --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1804-lts,size=15 \
    --ssh-key ~/.ssh/appuser.pub
done (21s)
id: fhmhfgr7hb4c9hepr9d3
...
network_interfaces:
  - index: "0"
    mac_address: d0:0d:11:7c:36:78
    subnet_id: e9bqom95bd1o3fkemarr
    primary_v4_address:
      address: 10.128.0.4
      one_to_one_nat:
        address: 51.250.93.5
        ip_version: IPV4
...

$ docker-machine create \
    --driver generic \
    --generic-ip-address=51.250.93.5 \
    --generic-ssh-user yc-user \
    --generic-ssh-key ~/.ssh/appuser \
    docker-host
Running pre-create checks...
Creating machine...
(docker-host) Importing SSH key...
Waiting for machine to be running, this may take a few minutes...
Detecting operating system of created instance...
Waiting for SSH to be available...
Detecting the provisioner...
Provisioning with ubuntu(systemd)...
Installing Docker...
Copying certs to the local machine directory...
Copying certs to the remote machine...
Setting Docker configuration on the remote daemon...
Checking connection to Docker...
Docker is up and running!
To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env docker-host

$ docker-machine ls
NAME          ACTIVE   DRIVER    STATE     URL                      SWARM   DOCKER      ERRORS
docker-host   *        generic   Running   tcp://51.250.93.5:2376           v20.10.17

$ docker-machine ip docker-host
51.250.93.5

$ eval $(docker-machine env docker-host)
```

Run Prometheus:
```
$ docker run --name prometheus --rm -d -p 9090:9090 prom/prometheus
Unable to find image 'prom/prometheus:latest' locally
latest: Pulling from prom/prometheus
...
Status: Downloaded newer image for prom/prometheus:latest
8086c215b74860d75273a383d694d65525df1a3674c2d8ac88ee852e4c27b03b

$ docker ps
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS          PORTS                                       NAMES
8086c215b748   prom/prometheus   "/bin/prometheus --c…"   15 seconds ago   Up 12 seconds   0.0.0.0:9090->9090/tcp, :::9090->9090/tcp   prometheus
```

Open http://51.250.93.5:9090/ and get acquainted with Prometheus.

Stop Prometheus:
```
$ docker stop prometheus
prometheus
```

Build a Prometheus Docker image to monitor the application:
```
$ cd monitoring/prometheus
$ export USERNAME=vshender
$ docker build -t $USERNAME/prometheus .
...
```

Build the application microservice images:
```
$ cd ../../

$ for srv in ui post-py comment; do cd src/$srv; USER_NAME=$USERNAME bash docker_build.sh; cd -; done
...
```

Run the application:
```
$ cd docker

$ cp .env.example .env

$ docker-compose up -d
[+] Running 7/7
 ⠿ Network docker_front_net       Created                                   0.1s
 ⠿ Network docker_back_net        Created                                   0.1s
 ⠿ Container docker-db-1          Started                                   2.3s
 ⠿ Container docker-post-1        Started                                   3.8s
 ⠿ Container docker-ui-1          Started                                   3.4s
 ⠿ Container docker-comment-1     Started                                   4.7s
 ⠿ Container docker-prometheus-1  Started
...
```

- Open http://51.250.93.5:9292/ and check the application.
- Open http://51.250.93.5:9090/ adn check the Prometheus.

Rebuild the Prometheus Docker image with the node-exporter configuration added:
```
$ cd ../monitoring/prometheus

$ docker build -t $USERNAME/prometheus .
...
```

Rerun the application:
```
$ cd ../../docker

$ docker-compose down
[+] Running 7/7
 ⠿ Container docker-post-1        Removed                                   2.9s
 ⠿ Container docker-prometheus-1  Removed                                   3.0s
 ⠿ Container docker-ui-1          Removed                                   2.3s
 ⠿ Container docker-db-1          Removed                                   2.1s
 ⠿ Container docker-comment-1     Removed                                   3.0s
 ⠿ Network docker_front_net       Removed                                   0.1s
 ⠿ Network docker_back_net        Removed                                   0.1s

$ docker-compose up -d
[+] Running 8/8
 ⠿ Network docker_back_net           Created                                0.1s
 ⠿ Network docker_front_net          Created                                0.1s
 ⠿ Container docker-db-1             Started                                3.0s
 ⠿ Container docker-post-1           Started                                4.9s
 ⠿ Container docker-node-exporter-1  Started                                2.2s
 ⠿ Container docker-comment-1        Started                                3.7s
 ⠿ Container docker-ui-1             Started                                4.1s
 ⠿ Container docker-prometheus-1     Started                                2.7s
```

- Open http://51.250.93.5:9090/targets and check the node-exporter target.
- Check the `node_load1` metric: http://51.250.93.5:9090/graph?g0.range_input=1h&g0.expr=node_load1&g0.tab=0.
- Add load:

  ```
  $ docker-machine ssh docker-host
  ...
  yc-user@docker-host:~$ yes > /dev/null
  ^C

  yc-user@docker-host:~$ exit
  logout
  ```
- Check the `node_load1` metric again.

Push the created application images to DockerHub:
```
$ docker login
Authenticating with existing credentials...
Login Succeeded

...

$ for image in ui comment post prometheus; do docker push $USERNAME/$image; done
...
```

DockerHub profile: https://hub.docker.com/u/vshender.

Build the mongodb-exporter image:
```
$ cd ../monitoring/mongodb

$ docker build -t $USERNAME/mongodb-exporter .
...
```

Rebuild the Prometheus Docker image with the mongodb-exporter configuration added:
```
$ cd ../prometheus

$ docker build -t $USERNAME/prometheus .
...
```

Rerun the application:
```
$ cd ../../docker

$ docker-compose down
[+] Running 8/8
 ⠿ Container docker-comment-1        Removed                                1.9s
 ⠿ Container docker-prometheus-1     Removed                                2.5s
 ⠿ Container docker-post-1           Removed                                2.4s
 ⠿ Container docker-node-exporter-1  Removed                                1.9s
 ⠿ Container docker-db-1             Removed                                1.7s
 ⠿ Container docker-ui-1             Removed                                2.5s
 ⠿ Network docker_front_net          Removed                                0.1s

$ docker-compose up -d
[+] Running 9/9
 ⠿ Network docker_back_net              Created                             0.1s
 ⠿ Network docker_front_net             Created                             0.1s
 ⠿ Container docker-ui-1                Started                             3.0s
 ⠿ Container docker-prometheus-1        Started                             3.2s
 ⠿ Container docker-db-1                Started                             4.8s
 ⠿ Container docker-node-exporter-1     Started                             3.4s
 ⠿ Container docker-post-1              Started                             6.6s
 ⠿ Container docker-comment-1           Started                             5.5s
 ⠿ Container docker-mongodb-exporter-1  Started                             4.2s
```

Open http://51.250.93.5:9090/targets and check the mongodb-exporter target.

</details>
