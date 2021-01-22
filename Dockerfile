FROM scottyhardy/docker-wine:latest
ENV WINEPATH=/usr/share/wine/teraterm
RUN mkdir /usr/share/wine/teraterm && \
	mkdir /tmp/install && \
	cd /tmp/install && \
	wget https://ymu.dl.osdn.jp/ttssh2/72009/teraterm-4.105.zip && \
	unzip teraterm-4.105.zip && \
	cd teraterm-4.105 && \
	cp -a . /usr/share/wine/teraterm && \
	rm -rf /tmp/install
# Boot 'er up, install consolas fonts, and then shut down
RUN xvfb-run sh -c "wineboot -i && winetricks consolas && wineboot -s"
ENTRYPOINT ["/usr/bin/entrypoint"]
