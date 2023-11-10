#!/usr/bin/env bash

# Since /root/.cache is in a volume, this should be cached
# for subsequent installations
pip install git+https://github.com/openai/whisper.git

cd /app
python3 run.py
