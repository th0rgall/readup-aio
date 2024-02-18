FROM alpine:3.19.1
RUN apk add --update --no-cache libintl gettext openssl bash
COPY --chmod=0755 . /
ENTRYPOINT ["/bin/bash", "-c", "./setup.sh"]