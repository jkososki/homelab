FROM alpine:3.19

RUN apk add --no-cache git-daemon 

VOLUME /git
EXPOSE 9418

CMD ["git", "daemon", "--verbose", "--enable=receive-pack", "--base-path=/git", "--export-all"]