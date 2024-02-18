# cron uses the Postgres container as a base, because it needs
# access to psql
FROM alpine
# RUN apt-get update && apt-get install -y cron
RUN apk update && apk add curl postgresql-client
# Based on:
# - https://stackoverflow.com/a/74922273/4973029
# - https://stackoverflow.com/a/60816190/4973029
# Provision first crontab which has to be volume-mounted into the container
# -f      Foreground
# -l N    Set log level. Most verbose 0, default 8
# crontab /crontab seems the same as Cat /crontab > /etc/crontabs/root
CMD ["/bin/sh", "-c", "\
    # To use env variables in the cron file https://stackoverflow.com/questions/27771781/how-can-i-access-docker-set-environment-variables-from-a-cron-job#comment109034883_41938139
    printenv > /etc/environment \
    && crontab /crontab \
    && crond -f -l 2 \
    "]