FROM sstarcher/sensu:latest

USER root

ENV TRANSPORT_NAME=redis
ENV REDIS_HOST=redis
ENV  LOG_LEVEL=debug

COPY conf/* /etc/sensu/conf.d/
COPY handlers/* /etc/sensu/conf.d/
COPY checks/* /etc/sensu/check.d/
COPY mutators/* /etc/sensu/conf.d/
COPY bin/*.rb /opt/sensu/embedded/bin/


VOLUME ["/var/log/sensu"]

# Curl is needed by the metrics-curl check that is run
RUN apt-get update && apt-get install -y curl && rm -r /var/lib/apt/lists/*

# Plugins needed for handlers
# RUN sensu-install -P sensu-plugins-slack,sensu-plugins-pagerduty

# Plugins needed for checks and maybe handlers
RUN sensu-install -P sensu-plugins-docker,sensu-plugins-dns,sensu-plugins-network-checks,sensu-plugins-mysql,sensu-plugins-sensu

# Unreleased Plugins
RUN /bin/install influxdb http ftp sstarcher/systemd
