FROM debian:9.5-slim

LABEL "com.github.actions.name"="DocFX - Generate TypeScript Documentation"
LABEL "com.github.actions.description"="Generates TypeScript API documentation from an npm package."
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/dend/actions"
LABEL "homepage"="https://den.dev"
LABEL "maintainer"="Den <noreply@den.dev>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
