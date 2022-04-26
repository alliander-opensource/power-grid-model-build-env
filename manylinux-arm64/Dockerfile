FROM quay.io/pypa/manylinux2014_aarch64

ENV CXX=g++
ENV CC=gcc
ENV PKG_ROOT=/opt/pkg
ENV CMAKE_PREFIX_PATH=/opt/cpp_pkgs
ENV EIGEN_INCLUDE=${CMAKE_PREFIX_PATH}/include/eigen3
ENV BOOST_INCLUDE=${CMAKE_PREFIX_PATH}/include
ENV BOOST_URL=https://boostorg.jfrog.io/artifactory/main/release/1.79.0/source/boost_1_79_0.tar.gz
ENV EIGEN_URL=https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.gz


# install build packages
RUN yum install -y epel-release && \
    yum update -y && \
    yum repolist && \
    yum install -y curl zip unzip tar git make cmake3 ninja-build wget && \
    yum clean all


# conda
RUN mkdir -p ${PKG_ROOT} && \
    mkdir -p ${EIGEN_INCLUDE} && \
    mkdir -p ${BOOST_INCLUDE} && \
    wget ${EIGEN_URL} -O ${PKG_ROOT}/eigen.tar.gz && \
    wget ${BOOST_URL} -O ${PKG_ROOT}/boost.tar.gz && \
    cd ${PKG_ROOT} && \
    tar -xzf eigen.tar.gz && \
    tar -xzf boost.tar.gz && \
    rm *.tar.gz && \
    cp -r eigen*/Eigen ${EIGEN_INCLUDE} && \
    cp -r boost*/boost ${BOOST_INCLUDE} && \
    cd / && \
    rm -rf ${PKG_ROOT}

CMD [ "/bin/bash" ]