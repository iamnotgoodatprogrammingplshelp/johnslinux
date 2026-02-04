
FROM ubuntu:latest


ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get install -y \
    build-essential \
    gcc-riscv64-unknown-elf \
    qemu-system-misc \
    make \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /os



CMD ["make", "run"]
