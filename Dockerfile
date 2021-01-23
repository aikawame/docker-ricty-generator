FROM ubuntu:20.04

WORKDIR /opt/project

RUN apt-get update \
 && apt-get install -y \
      fontforge-nox \
      fonttools \
      unzip \
      wget \
      zip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget https://rictyfonts.github.io/files/ricty_generator.sh -O /usr/local/bin/ricty_generator \
 && chmod 755 /usr/local/bin/ricty_generator

COPY entrypoint.sh /opt/project

ENTRYPOINT ["/opt/project/entrypoint.sh"]
