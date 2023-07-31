FROM homeassistant/home-assistant:stable

EXPOSE 8123

VOLUME /config

COPY run.sh /

CMD /run.sh