FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# 1. Instala todo como root
RUN apt-get update && \
    apt-get install -y sudo curl unzip python3-pip software-properties-common lsb-release gnupg git apt-transport-https ca-certificates openjdk-17-jdk

# 2. Instala Jenkins como root
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null && \
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null && \
    apt-get update && \
    apt-get install -y jenkins

# 3. Terraform, Go, AWS CLI, Ansible
RUN wget https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_amd64.zip && \
    unzip terraform_1.8.5_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.8.5_linux_amd64.zip

RUN apt-get update && apt-get install -y ansible

RUN pip3 install awscli

RUN wget https://go.dev/dl/go1.22.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz && \
    rm go1.22.4.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

# 4. Crea tu usuario solo al final
RUN useradd -m -s /bin/bash arheanja && \
    echo "arheanja ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 5. Da permisos a Jenkins para evitar errores
RUN chown -R jenkins:jenkins /var/lib/jenkins /var/log/jenkins /var/cache/jenkins || true

# 6. WORKDIR y usuario para el desarrollo
USER arheanja
WORKDIR /home/arheanja
