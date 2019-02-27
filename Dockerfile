FROM alpine:3.7

ENV DOT_ENV_VERSION '1.1.10'

ADD https://github.com/flipboxlabs/aws.env/archive/${DOT_ENV_VERSION}.zip /opt/


RUN apk add unzip jq && \
    apk -Uuv add groff less python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/* && \
    apk add --no-cache mysql-client bash && \
    unzip "/opt/${DOT_ENV_VERSION}.zip" -d /opt && \
    mv -fv "/opt/aws.env-${DOT_ENV_VERSION}/bin/" /usr/local/ && \
    dotenv

COPY docker-entrypoint /usr/local/bin

COPY scripts/* /usr/local/bin

RUN chmod +x -R /usr/local/bin/

ENV AWS_PARAMETER_PATH ''

ENV AWS_DEFAULT_REGION us-east-1
ENV AWS_DEFAULT_OUTPUT json

VOLUME /root/.aws

ENTRYPOINT ["docker-entrypoint"]

CMD ["bash"]
