# Dockerfile
FROM ubuntu:22.04

# Предотвращаем интерактивные запросы при установке
ENV DEBIAN_FRONTEND=noninteractive

# Установка компиляторов, CMake, ccache и Git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \ 
        build-essential \
        cmake \
        ccache \
        ninja-build \
        git \
        python3 \
        curl \
    && rm -rf /var/lib/apt/lists/*

# Добавляем ccache в PATH (приоритет над системными gcc/g++)
ENV PATH="/usr/lib/ccache:/usr/local/lib/ccache:$PATH"

# Обновляем хранилище сертификатов (на всякий случай)
RUN update-ca-certificates

# Создаём символические ссылки для прозрачного использования ccache
RUN ln -sf /usr/bin/ccache /usr/local/bin/gcc && \
    ln -sf /usr/bin/ccache /usr/local/bin/g++ && \
    ln -sf /usr/bin/ccache /usr/local/bin/cc

# Рабочая директория
WORKDIR /workspace