FROM ubuntu:18.04

LABEL "com.github.actions.name"="Publish blog"
LABEL "com.github.actions.description"="Publishes blog to AWS."
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/dend/blog"
LABEL "homepage"="https://dennisdel.com"
LABEL "maintainer"="Den <d@dsc.ai>"

RUN apt-get update \
    && apt-get install powershell --yes

ADD entrypoint.ps1 /entrypoint.ps1
ENTRYPOINT ["pwsh", "/entrypoint.ps1"]