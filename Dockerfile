FROM scottyhardy/docker-wine:latest
ADD https://ymu.dl.osdn.jp/ttssh2/72009/teraterm-4.105.zip /tmp/install/teraterm-4.105.zip
ENV WINEPATH=/usr/share/wine/teraterm
# Install x11vnc
RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        x11vnc \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir /usr/share/wine/teraterm && \
	mkdir -p /tmp/install && \
	cd /tmp/install && \
	unzip teraterm-4.105.zip && \
	cd teraterm-4.105 && \
	cp -a . /usr/share/wine/teraterm && \
	rm -rf /tmp/install
# Boot 'er up, install consolas fonts, and then shut down
RUN xvfb-run sh -c "wineboot -i && winetricks consolas && wineboot -s"
ENTRYPOINT ["/usr/bin/entrypoint"]
