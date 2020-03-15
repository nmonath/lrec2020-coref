#!/usr/bin/env bash

set -exu

idx=$1

echo "CUDA_VISIBLE_DEVICES $CUDA_VISIBLE_DEVICES"

python scripts/bert_coref.py -m train \
-w models/crossval/$idx.model \
-t data/litbank_tenfold_splits/$idx/train.conll \
-v data/litbank_tenfold_splits/$idx/dev.conll \
-o preds/crossval/$idx.dev.pred \
-s reference-coreference-scorers/scorer.pl> logs/crossval/$idx.log 2>&1
