#!/bin/bash
if curl "https://validator.w3.org/feed/check.cgi?url=${FEED_URL}" | grep "This is a valid RSS feed."
then
    echo "The feed is valid."
    exit 0
else
    echo "The feed is invalid."
    exit 1
fi
