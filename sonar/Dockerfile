FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV CXX g++-10
ENV CC gcc-10
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
    apt-get install -y curl zip unzip tar git build-essential gcovr lcov gcc g++ gcc-10 g++-10 clang clang-11 make cmake gdb ninja-build pkg-config python3.9 python3.9-dev python3.9-venv python3-pip && \
    apt-get clean -y && \
    python3.9 -m pip install --upgrade pip --no-cache-dir && \
    python3.9 -m pip install --no-cache-dir mkl mkl-include mkl-devel && \
    python3.9 -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir numpy cython pytest pytest-cov twine


# vcpkg
RUN cd /opt && \
	git clone https://github.com/Microsoft/vcpkg.git && \
	cd vcpkg && \
	./bootstrap-vcpkg.sh && \
	./vcpkg install eigen3 nlohmann-json msgpack catch2 boost tbb openblas[core] && \
	rm -rf downloads &&\
	rm -rf buildtrees &&\
	rm -rf packages

CMD [ "/bin/bash" ]
