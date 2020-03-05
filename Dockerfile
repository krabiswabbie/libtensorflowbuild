# Create libTensorFlow 1.15 (Cuda 10.1) image

FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
LABEL maintainer="Eugene FILIN <eugene.filin@gmail.com>"

WORKDIR /home

# Install gcc-6 (!)
# https://github.com/tensorflow/tensorflow/issues/26155#issuecomment-475896599
RUN apt-get update && \
apt-get install -y wget unzip git build-essential software-properties-common && \
add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
apt-get update && \
apt-get install -y gcc-6 g++-6 && \
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 && \
gcc -v

# Install Bazel-0.26.1
# libTensorFlow-1.15 only works with Bazel-0.24 to Bazel-0.26
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.26.1/bazel-0.26.1-installer-linux-x86_64.sh && \
chmod +x bazel-0.26.1-installer-linux-x86_64.sh && \
./bazel-0.26.1-installer-linux-x86_64.sh && \
rm ./bazel-0.26.1-installer-linux-x86_64.sh

# Install Python and the TensorFlow package dependencies
RUN apt-get install -y python-dev python-pip
RUN pip install -U pip six numpy wheel setuptools mock 'future>=0.17.1' && \
pip install -U keras_applications --no-deps && \
pip install -U keras_preprocessing --no-deps

# Download the TensorFlow source code & configure the build
RUN git clone https://github.com/tensorflow/tensorflow.git && \
cd tensorflow && \
git checkout r1.15

# Emulate ./configure on TensorFlow
# Compute capabilities:
# 3.7 - Tesla K80
# 5.0 - GeForce GTX 750ti
# 7.5 - GeForce RTX 2080ti
WORKDIR /home/tensorflow
RUN printf 'build --host_force_python=PY2 \n\
build --action_env PYTHON_BIN_PATH="/usr/bin/python" \n\
build --action_env PYTHON_LIB_PATH="/usr/local/lib/python2.7/dist-packages" \n\
build --python_path="/usr/bin/python" \n\
build:xla --define with_xla_support=true \n\
build --config=xla \n\
build --action_env CUDA_TOOLKIT_PATH="/usr/local/cuda" \n\
build --action_env TF_CUDA_COMPUTE_CAPABILITIES="3.7,5.0,7.5" \n\
build --action_env GCC_HOST_COMPILER_PATH="/usr/bin/gcc" \n\
build --config=cuda \n\
build:opt --copt=-march=native \n\
build:opt --copt=-Wno-sign-compare \n\
build:opt --host_copt=-march=native \n\
build:opt --define with_default_optimizations=true \n\
build:v2 --define=tf_api_version=2 \n\
test --flaky_test_attempts=3 \n\
test --test_size_filters=small,medium \n\
test --test_tag_filters=-benchmark-test,-no_oss,-oss_serial \n\
test --build_tag_filters=-benchmark-test,-no_oss \n\
test --test_tag_filters=-gpu \n\
test --build_tag_filters=-gpu \n\
build --action_env TF_CONFIGURE_IOS="0" \n' > .tf_configure.bazelrc

ARG TMP=/tmp
ENTRYPOINT bazel build --config opt //tensorflow/tools/lib_package:libtensorflow_test
