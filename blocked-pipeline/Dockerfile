FROM ubuntu:18.04

LABEL "com.github.actions.name"="Unexpected drift"
LABEL "com.github.actions.description"="Blocks pipeline."
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/dend/actions"
LABEL "homepage"="https://den.dev"
LABEL "maintainer"="Den <noreply@den.dev>"

ADD entrypoint.sh /entrypoint.sh
ADD ever.txt /ever.txt

ENTRYPOINT ["/entrypoint.sh"]
