FROM ubuntu:18.04

LABEL "com.github.actions.name"="Generate Halo Asset Performance Plot"
LABEL "com.github.actions.description"="Generates a set of plots that can be used to track the performance of Halo Infinite maps and game modes."
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/dend/actions"
LABEL "homepage"="https://den.dev"
LABEL "maintainer"="Den <noreply@den.dev>"

COPY requirements.txt /requirements.txt
COPY plotgen.py /plotgen.py

RUN ls

RUN apt-get update \
    && apt-get install python3 python3-pip -y

RUN pip3 install -r requirements.txt

CMD ["python3", "/plotgen.py"]
