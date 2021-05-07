FROM azadehafzarhub/gitlab-ci-ubuntu-build:latest

LABEL maintainer="Mohammad Mahdi Baghbani Pourvahid <MahdiBaghbani@protonmail.com>"

# install pip for sytem python (manually installed pythons via pyenv already have pip installed).
RUN apt install --yes python3-pip

# install utils for comiling python interpreter.
# requirements from pyenv wiki at https://github.com/pyenv/pyenv/wiki/Common-build-problems
RUN apt install --yes build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl

# install pipenv using default system python version.
RUN pip3 install --upgrade pipenv

# upgrade pip.
RUN pip3 install --upgrade pip

# install other python dependencies.
RUN pip3 install --upgrade setuptools
RUN pip3 install --upgrade wheel
RUN pip3 install --upgrade twine

# install pyenv.
RUN curl https://pyenv.run | bash

# setup pyenv.
RUN echo "export PATH=~/.pyenv/bin:$PATH" >> ~/.bash_profile
RUN echo "eval '$(pyenv init -)'" >> ~/.bash_profile
RUN echo "eval '$(pyenv virtualenv-init -)'" >> ~/.bash_profile

# install python versions.
RUN pyenv install 3.6.13
RUN pyenv install 3.7.10
RUN pyenv install 3.8.8

# make sure default python version is set to system.
RUN pyenv global system
