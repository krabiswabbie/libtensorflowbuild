Данный образ собирает из исходников библиотеку libTensorFlow-1.15 (Cuda-10.1)

## Сборка образа и запуск контейнера
```bash
docker build . -t libtensorflowbuild

docker run --name libtf libtensorflowbuild bash
docker cp libtf:/home/tensorflow/bazel-bin/tensorflow/tools/lib_package/libtensorflow.tar.gz $PWD
docker rm -f libtf
```

При запуске контейнера в нем автоматически запустится сборка libTensorFlow, которая может занять продолжительное время (несколько часов). После работы контейнера в текущей директории появятся файлы библиотеки.

## Release
Файлы библиотеки libTensorFlow-1.15 под Cuda-10.1 доступны в разделе [Releases](https://github.com/krabiswabbie/libtensorflowbuild/releases).