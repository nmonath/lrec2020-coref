#!/usr/bin/env bash

set -exu

conda create -n litbank_coref python=3.6

pip install -r requirements.txt