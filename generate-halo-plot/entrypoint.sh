#!/bin/bash -l

ls

python3 -m venv .env
source .env/bin/activate

pip install -r requirements.txt

python3 plotgen.py $WORKING_DIRECTORY