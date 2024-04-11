# Use the latest Python Version as the base image
FROM python:3.12-bookworm

# Set timezone
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Setup user
ARG USERNAME=omar.jamil
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && adduser $USERNAME sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Get latest git - added on 10 Sep 2022, as base image contained git 2.31 which is insufficient for
# signing git commits using an SSH. When base image contains git >= 2.34, this section can be
# removed
RUN apt-get update \
    && apt-get install software-properties-common -y \
    && apt-get install openssh-client -y \
    && apt-get install curl -y \
    && apt-get install npm -y \
    && apt-get install tmux -y

# [Optional] Uncomment this section to install Chrome for web scraping
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#     && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
#     && apt-get update \
#     && apt-get -y install google-chrome-stable \
#     && apt-get clean

# Copy environment.yml to a temp location so we update the environment.
COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY ide_setup.sh /home/$USERNAME/ 
RUN bash /home/$USERNAME/ide_setup.sh /home/$USERNAME 
RUN chown -R $USERNAME /home/$USERNAME
