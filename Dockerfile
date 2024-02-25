FROM ubuntu:22.04

RUN apt update && \
    apt-get update && \
    apt install -y \
        curl \
        git \
        sudo
        # build-essential \

# RUN git clone https://github.com/ppdx999/dotfiles.git
COPY . /dotfiles
RUN /dotfiles/install.sh
RUN bash
