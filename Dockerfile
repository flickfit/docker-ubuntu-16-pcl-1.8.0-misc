FROM flickfit/ubuntu-16-pcl-1.8.0:latest

MAINTAINER Kenji Nomura <atatb23@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      libopencv-dev \
      libusb-1.0-0-dev \
      libboost-all-dev libproj-dev \
      wget unzip \
      && rm -rf /var/lib/apt/lists/*

# Build librealsense
RUN \
    git clone https://github.com/IntelRealSense/librealsense.git --depth 1 && \
    cd librealsense && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j 2 && make install && make clean && \
    cd ../../ && rm -rf librealsense

# Build lib_aruco
RUN \
    wget https://sourceforge.net/projects/aruco/files/2.0.19/aruco-2.0.19.zip --no-check-certificate && \
    unzip aruco-2.0.19.zip && \
    cd aruco-2.0.19 && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j 2 && make install && \
    cd ../../ && rm -rf aruco-2.0.19 && rm -f aruco-2.0.19.zip
