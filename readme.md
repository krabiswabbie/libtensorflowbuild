# English 
This docker image builds libTensorFlow-1.15 (Cuda-10.1) library from source files.

Depending on the operating system used (Ubuntu 16.04, 18.04), gcc compiler will use different versions of the glibc library, which may be critical for some projects. For Ubuntu 18.04, glibc-2.27 is used, while for Ubuntu 16.04, glibc-2.24 is used.

Build the image and launch the container
```bash
docker build . -t libtensorflowbuild

docker run --name libtf libtensorflowbuild bash
docker cp libtf:/home/tensorflow/bazel-bin/tensorflow/tools/lib_package/libtensorflow.tar.gz $PWD
docker rm -f libtf
```

Upon the container starts, libTensorFlow build process will start automatically, which can take a long time (several hours), depending on your hardware.

## Release
LibTensorFlow-1.15 binary files for Cuda-10.1 are available in the [Releases](https://github.com/krabiswabbie/libtensorflowbuild/releases) section.

# Russian
Данный образ собирает из исходников библиотеку libTensorFlow-1.15 (Cuda-10.1).

В зависимости от используемой операционной системы (Ubuntu 16.04, 18.04) компилятор gcc будет использовать различные версии библиотеки glibc, что может быть критично для некоторых проектов. Для Ubuntu 18.04 используется glibc-2.27, для Ubuntu 16.04 используется glibc-2.24.

## Сборка образа и запуск контейнера
```bash
docker build . -t libtensorflowbuild

docker run --name libtf libtensorflowbuild bash
docker cp libtf:/home/tensorflow/bazel-bin/tensorflow/tools/lib_package/libtensorflow.tar.gz $PWD
docker rm -f libtf
```

При запуске контейнера в нем автоматически запустится сборка libTensorFlow, которая может занять продолжительное время (несколько часов), в зависимости от мощности компьютера.

## Release
Файлы библиотеки libTensorFlow-1.15 под Cuda-10.1 доступны в разделе [Releases](https://github.com/krabiswabbie/libtensorflowbuild/releases).