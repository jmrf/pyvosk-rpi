# Vosk Server Docker for RPI

This repo is intended to help in building [vosk-api](https://github.com/alphacep/vosk-api)
docker images for Raspberry Pi by using `docker buildx` in a cross-compile style.
i.e.: Build in a `x86_64` linux machine for `armv7`.

----

<!--ts-->
* [Vosk for RPI](#vosk-for-rpi)
   * [Structure](#structure)
   * [How To](#how-to)
      * [Building the docker images](#building-the-docker-images)

<!-- Created by https://github.com/ekalinin/github-markdown-toc -->
<!-- Added by: ubuntu, at: Tue Apr 19 12:28:30 UTC 2022 -->

<!--te-->

## Structure

This repo contains 3 docker images:

 - [Dockerfile](dockerfiles/Dockerfile): Image to test the `vosk-api` installation
    and to test the `vosk-api` microphone example.

 - [Dockerfile.vosk-server](dockerfiles/Dockerfile.vosk-server): Image with Kaldi Vosk Server and an english model to build for `armv7`.

 - ~~[Dockerfile.kaldi-en](dockerfiles/Dockerfile.kaldi-en): Copy of [alphacep kaldi-en](https://github.com/alphacep/vosk-server/blob/master/docker/Dockerfile.kaldi-en) (vosk-server (en)) to build an `armv7` version.~~


## How To

### Building the docker images

> ⚠️ Some python images might have trouble building due to an old `libseccomp2`
> in some platforms. see: [this FAQ](https://docs.linuxserver.io/faq)

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC 648ACFD622F3D138
echo "deb http://deb.debian.org/debian buster-backports main" | \
    sudo tee -a /etc/apt/sources.list.d/buster-backports.list
sudo apt update
sudo apt install -t buster-backports libseccomp2
```


Regardless of the image we want to build, the first time, we need to initialize the multi-platform builder:

```bash
./scripts/init_multi-builder.sh
```

Once that's done, build with:

```bash
# To build the vosk-api microphone test example for armv7
make build-test-docker
```

```bash
# To build the vosk-server for armv7
build-vosk-server-docker
```
