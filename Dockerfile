FROM zabbix/zabbix-server-pgsql:alpine-3.2.1

ENV VAULT_ADDR=
ENV VAULT_TOKEN=

COPY consul-template_0.16.0_SHA256SUMS /usr/local/bin/consul-template_0.16.0_SHA256SUMS
COPY consul_template.hcl /etc/consul_template.hcl
COPY zabbix_server.conf.template /root/zabbix_server.conf.template

RUN apk add --update-cache curl unzip \

  && cd /usr/local/bin \

  && curl -L https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip -o consul-template_0.16.0_linux_amd64.zip \
  && sha256sum -c consul-template_0.16.0_SHA256SUMS \
  && unzip consul-template_0.16.0_linux_amd64.zip \
  && rm consul-template_0.16.0_linux_amd64.zip consul-template_0.16.0_SHA256SUMS \

  && echo 'Include=/usr/local/etc/zabbix_server.conf.d/*.conf' >> /etc/zabbix/zabbix_server.conf \

  && apk del curl unzip && rm -rf /var/cache/apk/*

ENTRYPOINT [ "consul-template", "-config", "/etc/consul_template.hcl" ]
