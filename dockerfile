# Use the latest ubnutu base image
FROM ubuntu:24.04

# Set timezone
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Setup user
ARG USERNAME=oj249
ARG GROUP_ID=1000
ARG USER_ID=1000

RUN groupadd -o -g ${GROUP_ID} $USERNAME \
    && useradd --uid ${USER_ID} --gid ${GROUP_ID} -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo adduser\
    && adduser $USERNAME sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get update \
    && apt-get install software-properties-common -y \
    && apt-get install openssh-client -y \
    && apt-get install curl -y \
    && apt-get install npm -y \
    && apt-get install tmux -y \
    && apt-get install pipx -y \
    && apt-get install ninja-build -y \
    && apt-get install gettext -y \
    && apt-get install cmake -y \
    && apt-get install unzip -y \
    && apt-get install curl -y \
    && apt-get install build-essential -y


# [Optional] Uncomment this section to install Chrome for web scraping
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#     && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
#     && apt-get update \
#     && apt-get -y install google-chrome-stable \
#     && apt-get clean

COPY ide_setup.sh /home/$USERNAME/ 
# COPY dev_env.sh /home/$USERNAME/

# RUN bash /home/$USERNAME/ide_setup.sh /home/$USERNAME 
RUN chown -R $USERNAME /home/$USERNAME

# Copy the requirements file
# COPY requirements.txt /home/$USERNAME
# RUN pip install --no-cache-dir -r requirements.txt

# Install poetry and manage all project environments that way
# RUN pipx ensurepath 
# RUN pipx install poetry

# For pixi
# https://pixi.sh/latest/#installation
# curl -fsSL https://pixi.sh/install.sh | bash
