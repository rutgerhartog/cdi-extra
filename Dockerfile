FROM rutgerhartog/cdi

# Install atom, firefox and texlive-full
USER root
RUN wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add - \
&& echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list \
&& apt-get clean && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  atom \
  firefox-esr \
  python3-pip \
  remmina \
  sudo \
  texlive-full \
  wireshark

# Download kubectl binary
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && mv kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

# Override pythontex to use Python 3 instead of 2 (which throws Pickle errors)
RUN rm /usr/bin/pythontex && ln -s /usr/bin/pythontex3 /usr/bin/pythontex

# Switch user
USER 1337

# Install atom packages
RUN apm install \
  atom-material-ui \
  atom-material-syntax \
  build \
  busy-signal \
  git-clone \
  pdf-view \
  spell-check

RUN pip3 install pygments pyyaml
