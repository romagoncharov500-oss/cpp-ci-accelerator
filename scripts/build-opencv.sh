#!/bin/bash
set -e

# Клонируем OpenCV (легковесно)
git clone --depth 1 https://github.com/opencv/opencv.git opencv-src

cd opencv-src

# Настраиваем и собираем
cmake -B build \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_LIST=core,features2d,imgproc,calib3d \
  -DBUILD_EXAMPLES=OFF \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DBUILD_opencv_apps=OFF \
  -DBUILD_opencv_videoio=OFF \
  -DBUILD_opencv_highgui=OFF \
  -DBUILD_opencv_imgcodecs=OFF \
  -DBUILD_opencv_python3=OFF \
  -DWITH_CUDA=OFF \
  -DWITH_FFMPEG=OFF \
  -DWITH_V4L=OFF \
  -DWITH_GSTREAMER=OFF \
  -DWITH_OPENEXR=OFF \
  -DWITH_OPENJPEG=OFF

time cmake --build build --parallel $(nproc || sysctl -n hw.logicalcpu)