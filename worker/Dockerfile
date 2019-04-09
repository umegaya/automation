FROM jenkins/jenkins:lts

# install docker to run docker commands from jenkins container
ENV DOCKER_VERSION=18.06.1-ce
USER root
RUN curl -o /docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz && \
	tar -zxvf /docker.tgz && cp /docker/docker* /usr/bin && rm -rf /docker /docker.tgz

# install docker machine to control remote machine from jenkins container
ENV DOCKER_MACHINE_VERSION=v0.16.0
RUN apt-get update && apt-get install -y sudo make gawk && rm -rf /var/lib/apt/lists/*
RUN addgroup admin && adduser jenkins admin
RUN echo "%admin  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN curl -L https://github.com/docker/machine/releases/download/$DOCKER_MACHINE_VERSION/docker-machine-`uname -s`-`uname -m` > /tmp/docker-machine && chmod +x /tmp/docker-machine && mv /tmp/docker-machine /usr/local/bin 

# install js execution environment
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - 
RUN apt install nodejs && npm install -g n yarn && n lts

# install git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
RUN apt-get install git-lfs && git lfs install

# install jq
RUN curl -o /usr/bin/jq -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && chmod +x /usr/bin/jq

USER jenkins
