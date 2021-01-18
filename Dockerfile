FROM rutgerhartog/cdi

# Install atom, firefox and texlive-full
USER root
RUN wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add - \
&& echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list \
&& apt-get clean && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  atom \
  default-jdk \
  firefox-esr \
  python3-pip \
  remmina \
  sudo \
  texlive-full \
  wireshark

# Override pythontex to use Python 3 instead of 2 (which throws Pickle errors)
RUN rm /usr/bin/pythontex && ln -s /usr/bin/pythontex3 /usr/bin/pythontex

USER 1337
# Install atom packages
RUN apm install \
  git-clone \
  language-latex \
  latex \
  pdf-view \
  pen-paper-coffee-syntax

RUN pip3 install pygments pyyaml
