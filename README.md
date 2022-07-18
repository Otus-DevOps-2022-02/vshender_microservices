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
$ cd docker-monolith

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

$ docker build -t vshender/post:1.0 ./post-py
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
$ docker build -t vshender/comment:2.0 ./comment
...
Successfully built a77efba79646
Successfully tagged vshender/comment:2.0

$ docker build -t vshender/ui:2.0 ./ui
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

</details>
