#!/bin/bash -l

ls

source .env/bin/activate
python3 plotgen.py $WORKING_DIRECTORY