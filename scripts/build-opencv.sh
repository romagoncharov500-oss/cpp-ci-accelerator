#!/bin/bash
set -e

git clone --depth 1 https://github.com/opencv/opencv.git src
cd src

# Определяем, включён ли ccache
if command -v ccache &> /dev/null; then
  CCACHE_LAUNCHER="-DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache"
else
  CCACHE_LAUNCHER=""
fi

cmake -B build \
  -DCMAKE_BUILD_TYPE=Release \
  $CCACHE_LAUNCHER \
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

time cmake --build build --parallel $(nproc 2>/dev/null || sysctl -n hw.logicalcpu)

if command -v ccache &> /dev/null; then
  echo "=== ccache stats ==="
  ccache -s
fi