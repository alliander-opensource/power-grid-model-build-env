FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV CXX clang++-14
ENV CC clang-14
ENV LLVM_COV=llvm-cov-14
ENV VCPKG_FEATURE_FLAGS -binarycaching
ENV VCPKG_ROOT /opt/vcpkg
ENV MKL_INCLUDE /usr/local/include
ENV MKL_LIB /usr/local/lib
ENV EIGEN_INCLUDE ${VCPKG_ROOT}/installed/x64-linux/include/eigen3
ENV BOOST_INCLUDE ${VCPKG_ROOT}/installed/x64-linux/include
ENV MKL_THREADING_LAYER SEQUENTIAL
ENV MKL_INTERFACE_LAYER LP64
ENV LD_LIBRARY_PATH ${MKL_LIB}:${LD_LIBRARY_PATH}


# install build packages and mkl
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y curl zip unzip tar git build-essential gcovr lcov gcc g++ clang make cmake gdb ninja-build pkg-config python3.10 python3.10-dev python3.10-venv python3-pip && \
    apt-get clean -y && \
    python3.10 -m pip install --upgrade pip --no-cache-dir && \
    python3.10 -m pip install --no-cache-dir mkl mkl-include mkl-devel && \
    python3.10 -m venv /opt/venv


# vcpkg
RUN cd /opt && \
	git clone https://github.com/Microsoft/vcpkg.git && \
	cd vcpkg && \
	./bootstrap-vcpkg.sh && \
	./vcpkg install eigen3 nlohmann-json catch2 boost && \
	rm -rf downloads &&\
	rm -rf buildtrees &&\
	rm -rf packages

CMD [ "/bin/bash" ]
