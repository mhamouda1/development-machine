#!/bin/bash
cd /tmp && \
apt-get install wget unzip -y && \
wget https://releases.hashicorp.com/terraform/0.12.9/terraform_0.12.9_linux_amd64.zip && \
mv terraform_0.12.9_linux_amd64.zip /usr/local/bin && \
cd /usr/local/bin && \
unzip terraform_0.12.9_linux_amd64.zip
