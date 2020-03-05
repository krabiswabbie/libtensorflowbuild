# English 
This docker image builds libTensorFlow-1.15 (Cuda-10.1) library from source files.

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