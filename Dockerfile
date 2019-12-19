FROM ubuntu:bionic

MAINTAINER Mohammad Mahdi Baghbani Pourvahid <MahdiBaghbani@protonmail.com>

# set frontend to noneinteractive.
ARG DEBIAN_FRONTEND=noninteractive

# change default shell from sh to bash.
SHELL ["/bin/bash", "-l", "-c"]

# update apt database.
RUN apt-get update --assume-yes

# install apt utils to speed up configs.
RUN apt-get install --assume-yes --no-install-recommends apt-utils

# install latest libc6 library.
RUN apt-get install --assume-yes libc6

# set locale.
RUN apt-get install --assume-yes locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# install git.
RUN apt-get install --assume-yes git

# install curl.
RUN apt-get install --assume-yes curl

# install pipenv.
RUN apt-get install --assume-yes pipenv

# install codeclimate coverage reporter.
RUN curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > /usr/bin/cc-test-reporter
RUN chmod +x /usr/bin/cc-test-reporter

# install pyenv.
RUN curl https://pyenv.run | bash

# setup pyenv.
RUN echo "export PATH=~/.pyenv/bin:$PATH" >> ~/.bash_profile
RUN echo "eval '$(pyenv init -)'" >> ~/.bash_profile
RUN echo "eval '$(pyenv virtualenv-init -)'" >> ~/.bash_profile

# install ruby versions.
RUN pyenv install 3.6.9
RUN pyenv install 3.7.5
RUN pyenv install 3.8.0

# specify working directory.
ENV TESTBUILD ~/test_and_build
RUN mkdir -p $TESTBUILD
WORKDIR $TESTBUILD

