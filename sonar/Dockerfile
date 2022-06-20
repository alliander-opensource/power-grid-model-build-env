FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV CXX=clang++-14
ENV CC=clang-14
ENV LLVM_COV=llvm-cov-14
ENV CONDA_ROOT=/opt/conda
ENV CMAKE_PREFIX_PATH=/opt/cpp_pkgs
ENV EIGEN_INCLUDE=${CMAKE_PREFIX_PATH}/include/eigen3
ENV BOOST_INCLUDE=${CMAKE_PREFIX_PATH}/include
ENV MINICONDA_URL=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh



# install build packages
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y wget curl zip unzip tar git build-essential gcovr lcov gcc g++ clang make cmake gdb ninja-build pkg-config python3.10 python3.10-dev python3.10-venv python3-pip && \
    apt-get clean -y && \
    python3.10 -m venv /opt/venv


# conda
RUN wget "${MINICONDA_URL}" -O miniconda.sh -q && \
    mkdir -p /opt && \
    sh miniconda.sh -b -p ${CONDA_ROOT} && \
    rm miniconda.sh && \
    . ${CONDA_ROOT}/etc/profile.d/conda.sh && \
    conda activate base && \
    conda create --yes -p ${CMAKE_PREFIX_PATH} -c conda-forge boost-cpp eigen nlohmann_json doctest && \
    conda deactivate && \
    rm -rf ${CONDA_ROOT} && \
    rm /opt/cpp_pkgs/lib/libstd*.*


CMD [ "/bin/bash" ]
