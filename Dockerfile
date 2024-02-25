FROM ubuntu:22.04

RUN apt update && \
    apt-get update && \
    apt install -y curl git 

RUN git clone https://github.com/ppdx999/dotfiles.git
RUN /dotfiles/install.sh
RUN bash
