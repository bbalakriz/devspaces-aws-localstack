FROM localstack/localstack:stable

RUN ls -l / && ls -l /.cache || echo "No /.cache directory found"

RUN chgrp -R 0 /etc/passwd && \
    chmod -R g+rwX /etc/passwd && \
    rm -rf /tmp/localstack/* && \
    mkdir -p /.cache && \
    chgrp -R 0 /.cache && \
    chmod -R g+rwX /.cache || echo "/.cache not present, skipping permissions update"

COPY custom-entrypoint.sh /custom-entrypoint.sh
ENTRYPOINT ["/custom-entrypoint.sh"]

USER 1001
