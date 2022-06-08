FROM quay.io/pypa/manylinux2014_x86_64

ENV CXX=g++
ENV CC=gcc
ENV CONDA_ROOT=/opt/conda
ENV CMAKE_PREFIX_PATH=/opt/cpp_pkgs
ENV EIGEN_INCLUDE=${CMAKE_PREFIX_PATH}/include/eigen3
ENV BOOST_INCLUDE=${CMAKE_PREFIX_PATH}/include
ENV MINICONDA_URL=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh


# install build packages
RUN yum update -y && \
    yum install -y curl zip unzip tar git make cmake3 ninja-build wget && \
    yum clean all


# conda
RUN wget "${MINICONDA_URL}" -O miniconda.sh -q && \
    mkdir -p /opt && \
    sh miniconda.sh -b -p ${CONDA_ROOT} && \
    rm miniconda.sh && \
    . ${CONDA_ROOT}/etc/profile.d/conda.sh && \
    conda activate base && \
    conda create --yes -p ${CMAKE_PREFIX_PATH} -c conda-forge boost-cpp eigen nlohmann_json && \
    conda deactivate && \
    rm -rf ${CONDA_ROOT}


CMD [ "/bin/bash" ]