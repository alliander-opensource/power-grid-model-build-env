FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV CXX clang++-14
ENV CC clang-14
ENV LLVM_COV=llvm-cov-14
ENV MKL_INCLUDE /usr/local/include
ENV MKL_LIB /usr/local/lib
ENV CONDA_ROOT /opt/conda
ENV EIGEN_INCLUDE ${CONDA_ROOT}/include/eigen3
ENV BOOST_INCLUDE ${CONDA_ROOT}/include
ENV MKL_THREADING_LAYER SEQUENTIAL
ENV MKL_INTERFACE_LAYER LP64
ENV LD_LIBRARY_PATH ${MKL_LIB}:${LD_LIBRARY_PATH}
ENV MINICONDA_URL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
ENV CMAKE_PREFIX_PATH ${CONDA_ROOT}


# install build packages and mkl
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y wget curl zip unzip tar git build-essential gcovr lcov gcc g++ clang make cmake gdb ninja-build pkg-config python3.10 python3.10-dev python3.10-venv python3-pip && \
    apt-get clean -y && \
    python3.10 -m pip install --upgrade pip --no-cache-dir && \
    python3.10 -m pip install --no-cache-dir mkl mkl-include mkl-devel && \
    python3.10 -m venv /opt/venv


# conda
RUN wget "${MINICONDA_URL}" -O miniconda.sh -q && \
    mkdir -p /opt && \
    sh miniconda.sh -b -p ${CONDA_ROOT} && \
    rm miniconda.sh && \
    ln -s ${CONDA_ROOT}/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    . ${CONDA_ROOT}/etc/profile.d/conda.sh && \
    conda activate base && \
    find ${CONDA_ROOT}/ -follow -type f -name '*.a' -delete && \
    find ${CONDA_ROOT}/ -follow -type f -name '*.js.map' -delete && \
    conda install --yes -c conda-forge boost-cpp eigen nlohmann_json catch2 && \
    conda clean -afy


CMD [ "/bin/bash" ]
