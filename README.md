# Docker Imagem Golang 1.13.6

### Download da imagem

docker pull artifactory.santanderbr.corp/docker-base/golang-1.13.6:TAG_NAME

### Como usar a imagem

A imagem contém o script control.sh script, este script possui as seguintes opções.

#### Help

docker run --rm -ti artifactory.santanderbr.corp/docker-base/golang-1.13:TAG_NAME help
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

O start por default executa o arquivo /application.jar
```
docker run -d -p 0.0.0.0:8080:8080 artifactory.santanderbr.corp/docker-base/golang-1.13:TAG_NAME start
```

#### shell

```
docker run --rm -ti artifactory.santanderbr.corp/docker-base/golang-1.13:TAG_NAME shell
```

## Como criar uma imagem usando essa como FROM

O exemplo abaixo cria uma aplicação usando artifactory.santanderbr.corp/docker-base/golang-1.13.6:TAG_NAME como base.

Dockerfile

```
FROM artifactory.santanderbr.corp/docker-base/golang-1.13:TAG_NAME
ADD app /opt/app
```

```
docker build .
```

## Time Zone
Por default a imagem usa o time zone "America/Sao_Paulo", Se você quiser alterar crie uma variável TZ.
