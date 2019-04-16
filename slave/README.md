#### setup slave jenkins
``` bash 
# create ssh keys (for accessing host from jenkins job in container)
ssh-keygen -t rsa
# add automation repository
git clone https://github.com/umegaya/automation
# copy env sample to actual env file
cd automation && cp .env.sample .env
# configure env. see .env.sample explanation
# create slave image, configure ssh
make slave
# create jenkins home
sudo mkdir -p /private/var/jenkins_home
# create docker machine directory
mkdir -p ~/.docker/machine
# change ownership
sudo chown -R $your_user:$your_group /private/var/jenkins_home
# start slave
make sup
```

#### additional settings for slave container
- config HOST_SSH env on slave setting window of jenkins menu. port is 2022, which can be set from advanced setting
- if using HOST_SSH, should install git-lfs on host too