FROM centos:7

LABEL maintainer="Marcelo Melo marceloagmelo@gmail.com"

USER root

ENV GID 23550
ENV UID 23550

ENV GOLANG_VERSION 1.13.10
ENV GOLANG_DIR_TMP /tmp
ENV GOLANG_ARTIFACTORY_URL https://dl.google.com/go
ENV GOLANG_SHA256 aae5be954bdc40bcf8006eb77e8d8a5dde412722bc8effcdaf9772620d06420c

ENV IMAGE_SCRIPTS_HOME /opt/scripts

ADD scripts $IMAGE_SCRIPTS_HOME
COPY Dockerfile $IMAGE_SCRIPTS_HOME/Dockerfile

ENV GOPATH /go
ENV GOBIN /go/bin
ENV PATH $GOBIN:/usr/local/go/bin:$PATH
ENV GO111MODULE="on"

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 755 "$GOPATH/bin"

RUN yum clean all && yum update -y && yum -y install \
    git \
    net-tools \
    gcc-c++ \
    make && \
    curl --silent --output "${GOLANG_DIR_TMP}/go$GOLANG_VERSION.linux-amd64.tar.gz" --remote-name "$GOLANG_ARTIFACTORY_URL/go$GOLANG_VERSION.linux-amd64.tar.gz" && \
    #shasum -a 256 ${GOLANG_DIR_TMP}/go$GOLANG_VERSION.linux-amd64.tar.gz && \
    sha256sum ${GOLANG_DIR_TMP}/go$GOLANG_VERSION.linux-amd64.tar.gz && \
    #echo "${GOLANG_SHA256} ${GOLANG_DIR_TMP}/go$GOLANG_VERSION.linux-amd64.tar.gz" | sha256sum -c - && \
    tar -C /usr/local -xzf ${GOLANG_DIR_TMP}/go$GOLANG_VERSION.linux-amd64.tar.gz && \
    git config --global http.sslVerify false && \
    groupadd --gid $GID golang && useradd --uid $UID -m -g golang golang && \
    export PATH="/usr/local/go/bin:$PATH" && \
    go version && \
    echo "running..." >> /opt/run.log && \
    chown -R golang:golang $IMAGE_SCRIPTS_HOME && \
    chown -R golang:golang $GOPATH && \
    chown golang:golang /opt/run.log && \
    yum clean all && \
    rm -Rf /tmp/* && rm -Rf /var/tmp/*

EXPOSE 8080

USER golang

WORKDIR $IMAGE_SCRIPTS_HOME

ENTRYPOINT [ "./control.sh" ]
CMD [ "start" ]
