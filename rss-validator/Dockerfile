FROM ubuntu:18.04

LABEL "com.github.actions.name"="Validate RSS feed"
LABEL "com.github.actions.description"="Uses a public API to check whether a RSS feed is valid or not."
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/dend/actions"
LABEL "homepage"="https://den.dev"
LABEL "maintainer"="Den <noreply@den.dev>"

RUN apt-get update \
    && apt-get install curl -y

ADD entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
