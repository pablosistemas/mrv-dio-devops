## Getting started

Creating basic .NET Core WebApi using CLI:

```
dotnet new webapi -f netcoreapp3.1 -n DioDockerTutorial
```

Restoring packages:

```
dotnet restore DioDockerTutorial.csproj
```

Building Docker image:
```
docker build -t dio-docker-tutorial:1.0 -f Dockerfile .
```

Running WebApi in host port 8080:
```
docker run --detach --publish 8080:8080 --publish 8081:8081 --publish 8082:8082 --name dio-docker-tut dio-docker-tutorial:1.3
```

If you are using Docker native, so youy test must be done agains localhost. Using cUrl:
```
curl -X GET -v http://localhost:8080/weatherforecast
```

Alternatively, if you are using Docker Toolbox like me in the presentation, you must look for the docker-machine ip:
```
IP=`docker-machine ip default`
curl -X GET -v http://$IP:8080/weatherforecast
```

## Kubernetes

### Setup

You must create a namespace for your application:

```
kubectl create namespace dio-tutorial
```

### Docker Registry Secret

For creating a Kubernetes secret with Docker Registry credentials, I suggest you to run _docker login_ in your docker CLI and fill the authentication form. Docker will generate a _config.json_ file that you might use directly for Kubernetes secret creation:
```
kubectl create secret generic container-registry-secret -n dio-tutorial \
    --from-file=.dockerconfigjson=~/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson
```

### Deploy

```
kubectl apply -f -R /path/to/repository/yaml/
```