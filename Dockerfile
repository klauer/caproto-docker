FROM python:3.5
MAINTAINER caproto <>

USER root

RUN apt-get update
# get areadetector dependencies
RUN apt-get install -yq libhdf5-dev libx11-dev libxext-dev libxml2-dev libpng12-dev libbz2-dev libfreetype6-dev
RUN apt-get install -yq build-essential curl file git python-setuptools ruby

RUN mkdir -p /epics/iocs /epics/src

# - setup the softioc user
RUN useradd -ms /bin/bash softioc
USER softioc
WORKDIR /home/softioc

# - install homebrew and epics
RUN git clone https://github.com/Linuxbrew/brew.git $HOME/.linuxbrew
ENV PATH="/home/softioc/.linuxbrew/bin:${PATH}"

# RUN brew install perl --without-test
# TODO: i'm too lazy...
RUN mkdir -p /home/softioc/.linuxbrew/Cellar/perl
RUN ln -s /usr /home/softioc/.linuxbrew/Cellar/perl/5.24.1

RUN brew tap klauer/homebrew-epics
RUN brew install epics-base
RUN brew install epics-motor
RUN brew install --HEAD klauer/epics/pyepics-test-ioc
RUN brew install epics-autosave

# TODO move this up
USER root
RUN chown -R softioc:softioc /epics
USER softioc

# - install motorsim
RUN git clone https://github.com/klauer/motorsim --single-branch --branch homebrew-epics /epics/iocs/motorsim

RUN sed -i 's#/usr/local/#/home/softioc/.linuxbrew/#' /epics/iocs/motorsim/configure/*
RUN sed -i 's/darwin-x86/linux-x86_64/' /epics/iocs/motorsim/iocBoot/ioclocalhost/Makefile
RUN bash -c "source epics_env.sh && \
             cd /epics/iocs/motorsim && \
             make"
