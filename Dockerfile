FROM ubuntu:22.04 as base
RUN apt update -q && apt install -y ca-certificates wget && \
    wget -qO /cuda-keyring.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i /cuda-keyring.deb && apt update -q

FROM base as builder
RUN apt install -y --no-install-recommends git cuda-nvcc-12-2
RUN git clone --depth=1 https://github.com/nvidia/cuda-samples.git /cuda-samples
RUN cd /cuda-samples/Samples/1_Utilities/deviceQuery && \
    make && install -m 755 deviceQuery /usr/local/bin

FROM base as runtime
RUN apt install -y --no-install-recommends ffmpeg libcudnn8 libcublas-12-2 \
                                           git python3 python3-pip \
    && pip install git+https://github.com/openai/whisper.git

WORKDIR /app

COPY --from=builder /usr/local/bin/deviceQuery /usr/local/bin/deviceQuery
COPY run.py /app/run.py
COPY audio.mp3 /app/audio.mp3

CMD ["python3", "run.py"]

