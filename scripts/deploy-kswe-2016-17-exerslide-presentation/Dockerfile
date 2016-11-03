FROM node:7

RUN apt-get update && \
    apt-get install -y dos2unix

COPY entrypoint.sh* /
RUN for i in /entrypoint.sh* ; do \
        dos2unix $i ; \
    done

WORKDIR /

ENTRYPOINT /entrypoint.sh
