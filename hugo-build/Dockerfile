FROM ubuntu:18.04

LABEL "com.github.actions.name"="Publish blog to GitHub"
LABEL "com.github.actions.description"="Publishes a Hugo blog to GitHub.io."
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/dend/actions"
LABEL "homepage"="https://den.dev"
LABEL "maintainer"="Den <noreply@den.dev>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
