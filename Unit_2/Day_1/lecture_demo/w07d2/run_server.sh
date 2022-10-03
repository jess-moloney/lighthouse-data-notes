#!/bin/bash

until python3 app.py; do
    echo "Server 'app.py' crashed with exit code $?.  Respawning.." >&2
    sleep 1
done