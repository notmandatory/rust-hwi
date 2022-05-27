FROM rust

RUN apt-get update
RUN apt-get install scons libsdl2-dev python3 python3-pip libsdl2-image-dev llvm-dev libclang-dev clang protobuf-compiler libusb-1.0-0-dev -y
RUN git clone --recursive https://github.com/trezor/trezor-firmware/ trezor-firmware
WORKDIR /trezor-firmware/core
RUN pip install poetry hwi
RUN poetry install
RUN poetry run make build_unix
CMD ["poetry", "run", "./emu.py", "--headless", "--slip0014", "-q"]
