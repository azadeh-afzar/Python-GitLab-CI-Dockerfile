FROM azadehafzarhub/gitlab-ci-ubuntu-build:latest

LABEL maintainer="Mohammad Mahdi Baghbani Pourvahid <MahdiBaghbani@protonmail.com>"

# install pip for sytem python (manually installed pythons via pyenv already have pip installed).
RUN apt-get install --assume-yes python3-pip

# install pipenv using default system python version (3.6 in ubuntu bionic).
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
RUN pyenv install 3.6.9
RUN pyenv install 3.7.5
RUN pyenv install 3.8.0

# make sure default python version is set to system.
RUN pyenv global system

