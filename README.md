# Docker Imagem Golang 1.13.10

### Download da imagem

docker pull marceloagmelo/golang-1.13:TAG_NAME

### Como usar a imagem

A imagem contém o script control.sh script, este script possui as seguintes opções.

#### Help

docker run --rm -ti golang-1.13:TAG_NAME help
```
========================================
USAGE: /control.sh COMMAND [args]
  Command list:
    - info      : execute info scripts
    - shell     : execute shell scripts
    - start     : execute start scripts
    - status    : execute status scripts
    - test      : execute test scripts
========================================
```

#### Start

```
docker run -d -p 0.0.0.0:8080:8080 marceloagmelo/golang-1.13:TAG_NAME start
```

#### shell

```
docker run --rm -ti golang-1.13:TAG_NAME shell
```

## Como criar uma imagem usando essa como FROM

O exemplo abaixo cria uma aplicação usando marceloagmelo/golang-1.13.6:TAG_NAME como base.

Dockerfile

```
FROM golang-1.13:TAG_NAME
ADD app /go/src/github.com/app
RUN go mod init && go install
```

```
docker build NOME-IMAGEM .
```

## Time Zone
Por default a imagem usa o time zone "America/Sao_Paulo", Se você quiser alterar crie uma variável TZ.
