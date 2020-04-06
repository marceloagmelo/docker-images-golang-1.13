FROM centos:7

MAINTAINER Marcelo Melo <marcelo.melo@santander.com.br>

USER root

ENV GID 23550
ENV UID 23550

ENV GOLANG_VERSION 1.13.6
ENV GOLANG_DIR_TMP /tmp
ENV GOLANG_ARTIFACTORY_URL https://dl.google.com/go
ENV GOLANG_SHA256 aae5be954bdc40bcf8006eb77e8d8a5dde412722bc8effcdaf9772620d06420c

ENV APP_HOME /opt/app
ENV IMAGE_SCRIPTS_HOME /opt/scripts

RUN mkdir -p $APP_HOME && \
    mkdir $IMAGE_SCRIPTS_HOME

ADD scripts $IMAGE_SCRIPTS_HOME
COPY Dockerfile $IMAGE_SCRIPTS_HOME/Dockerfile
ADD app $APP_HOME

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
    chown -R golang:golang $APP_HOME && \
    chown -R golang:golang $IMAGE_SCRIPTS_HOME && \
    yum clean all && \
    rm -Rf /tmp/* && rm -Rf /var/tmp/*


#######################################################################
##### We have to expose image metada as label and ENV
#######################################################################
LABEL br.com.santander.imageowner="Corporate Techonology" \
      br.com.santander.description="Golang 1.13.6 runtime for node microservices" \
      br.com.santander.components="Golang Server"

ENV br.com.santander.imageowner="Corporate Techonology"
ENV br.com.santander.description="Golang 1.13.6 runtime for node microservices"
ENV br.com.santander.components="Golang Server"

EXPOSE 8080

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

USER golang

ENV GO111MODULE="on"

WORKDIR $IMAGE_SCRIPTS_HOME

ENTRYPOINT [ "./control.sh" ]
CMD [ "start" ]
