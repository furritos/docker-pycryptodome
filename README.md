# Dockerized PyCryptodome

This repository contains `Dockerfiles` for the following version of Python

 - 2.7
 - 3.4
 - 3.5
 - 3.6
 - 3.7

The advantage of this `Dockerfile` is that it relies on the `alpine` builds of Python (latest) and by doing so, will always pull the latest and greatest.

To use, just pull the appropriate Docker image or `git clone` this repository and `docker build` accordingly.

The following tags are available:

 - `2.7-alpine`
 - `3.4-alpine`
 - `3.5-alpine`
 - `3.6-alpine`
 - `3.7-alpine`

For example, pulling the latest Python 3.7 build would be:

```
docker pull furritos/pycryptodome:3.7-alpine
```
