# Azkaban Dockerized

Deploy Azkaban as Docker Container

## Getting Started

Azkaban doesn't come with docker container yet. So I tried to make docker image from azkaban source

### Prerequisites

Has docker installed on your machine

### Installing

There are two type of azkaban server, solo or multi executor mode

#### Solo Server

Solo server has all the processes is centralized on the machine

```
$ docker run dirathea/azkaban-solo:latest
```

#### Multi Executor

There are 2 images to be run

```
$ docker run dirathea/azkaban-web:latest
$ docker run dirathea/azkaban-executor:latest
```

## Built With

* [Docker](https://www.docker.com/) - The web framework used

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We follow the versions that came out from azkaban. For example,the latest version is `3.81.0`, so the image tag will be `3.81.0`

## Authors

* **Aldira Putra Raharja** - *Initial work* - [dirathea](https://github.com/dirathea)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

