FROM ubuntu:18.04

LABEL "com.github.actions.name"="Publish blog"
LABEL "com.github.actions.description"="Publishes blog to AWS."
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/dend/blog"
LABEL "homepage"="https://dennisdel.com"
LABEL "maintainer"="Den <d@dsc.ai>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]