FROM aaronknister/docker-wine:latest

ENV WINEPATH=/usr/share/wine/teraterm

# eoan is now "old"
RUN sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# Install x11vnc
RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        x11vnc \
    && rm -rf /var/lib/apt/lists/*

# Boot 'er up, install consolas fonts, and then shut down
RUN xvfb-run sh -c "wineboot -i && winetricks consolas && wineboot -s"

# Download and install teraterm
RUN mkdir -p /tmp/install \
    && cd /tmp/install \
    && wget https://ymu.dl.osdn.jp/ttssh2/72009/teraterm-4.105.zip 

RUN mkdir /usr/share/wine/teraterm && \
	mkdir -p /tmp/install && \
	cd /tmp/install && \
	unzip teraterm-4.105.zip && \
	cd teraterm-4.105 && \
	cp -a . /usr/share/wine/teraterm && \
	rm -rf /tmp/install

ENTRYPOINT ["/usr/bin/entrypoint"]
