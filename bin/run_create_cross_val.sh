#!/usr/bin/env bash


set -exu

mkdir -p models/crossval
mkdir -p preds/crossval
mkdir -p logs/crossval

python scripts/create_crossval.py data/litbank_tenfold_splits data/original/conll/  data/litbank_tenfold_splits
