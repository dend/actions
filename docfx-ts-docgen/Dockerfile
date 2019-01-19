FROM debian:9.5-slim

LABEL "com.github.actions.name"="DocFX - Generate TypeScript Documentation"
LABEL "com.github.actions.description"="Generates TypeScript API documentation from an npm package."
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/dend/docs-with-actions"
LABEL "homepage"="https://dennisdel.com"
LABEL "maintainer"="Den <dend@outlook.com>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
