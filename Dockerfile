# Use a newer Jenkins LTS image with Java 17
FROM jenkins/jenkins:2.462.3-jdk17

# Switch to root to install extra packages
USER root

# Install Docker CLI (so Jenkins jobs can run Docker commands)
RUN apt-get update && \
    apt-get install -y lsb-release curl python3-pip && \
    curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the Jenkins user
USER jenkins

# Install Blue Ocean and Docker workflow plugins
RUN jenkins-plugin-cli --plugins "blueocean:1.27.16 docker-workflow:1.30"

