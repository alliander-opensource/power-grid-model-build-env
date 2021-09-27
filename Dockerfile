FROM quay.io/pypa/manylinux2014_x86_64

ENV BASE_PYTHON_VERSION cp39-cp39
ENV VCPKG_FEATURE_FLAGS -binarycaching

# install build packages and mkl
RUN yum update -y && \
    yum install -y curl unzip tar git make cmake3 ninja-build python3 && \
    yum clean all && \
    pip3 install --upgrade pip --no-cache-dir && \
    pip3 install --no-cache-dir mkl mkl-devel


# global twine
RUN /opt/python/${BASE_PYTHON_VERSION}/bin/pip install --no-cache-dir twine && \
    ln -s /opt/python/${BASE_PYTHON_VERSION}/bin/twine /usr/local/bin/twine

# loop to install packages for all python versions
RUN sh -x && \
    for PYTHON_VERSION in cp37-cp37m cp38-cp38 cp39-cp39 cp310-cp310; \
        do \
            echo "===== installing python version ${PYTHON_VERSION} ====="; \
            /opt/python/${PYTHON_VERSION}/bin/pip install --no-cache-dir numpy cython pytest; \
        done \
    \
    #
    && echo "Finish Python install!"

# vcpkg
RUN cd /opt && \
	git clone https://github.com/Microsoft/vcpkg.git && \
	cd vcpkg && \
	./bootstrap-vcpkg.sh && \
	./vcpkg install eigen3 nlohmann-json msgpack catch2 boost tbb openblas[core] && \
	rm -rf downloads &&\
	rm -rf buildtrees &&\
	rm -rf packages

ENV CXX g++
ENV CC gcc
ENV VCPKG_ROOT /opt/vcpkg
ENV MKL_INCLUDE /usr/local/include
ENV MKL_LIB /usr/local/lib
ENV EIGEN_INCLUDE ${VCPKG_ROOT}/installed/x64-linux/include/eigen3
ENV BOOST_INCLUDE ${VCPKG_ROOT}/installed/x64-linux/include
ENV MKL_THREADING_LAYER SEQUENTIAL
ENV MKL_INTERFACE_LAYER LP64
ENV LD_LIBRARY_PATH ${MKL_LIB}:${LD_LIBRARY_PATH}

CMD [ "/bin/bash" ]
