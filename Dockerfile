FROM ubuntu:eoan

RUN apt update -qq && apt upgrade -qq -y
RUN apt install -y \
    curl \
    exuberant-ctags \
    git \
    jq \
    git-crypt \
    sudo \
    unzip \
    vim \
    python3-pip \
    docker.io \
    amazon-ecr-credential-helper \
    ;

RUN cd /tmp && \
    curl -O https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip && \
    unzip terraform_0.11.14_linux_amd64.zip && \
    mv terraform /usr/local/bin

RUN curl -sL https://sentry.io/get-cli/ | bash

RUN pip3 install awscli-cwlogs awscli-sqsall

RUN sed -i'' 's/^%sudo\t.*/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers

# You can get the right GID from running `stat -c "%g" /var/run/docker.sock` in
# the host.
RUN groupmod -g 130 docker

RUN useradd --create-home --shell /bin/bash pkoch && \
    adduser pkoch sudo && \
    adduser pkoch docker && \
    true;
USER pkoch
WORKDIR /home/pkoch/
