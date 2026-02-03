# Use a lightweight Linux base that has easy access to RISC-V tools
FROM ubuntu:latest

# prevent interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Update and install the toolchain and QEMU
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc-riscv64-unknown-elf \
    qemu-system-misc \
    make \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /os

# By default, running the container will try to build the project
CMD ["make", "run"]