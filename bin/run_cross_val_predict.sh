#!/usr/bin/env bash

set -exu

idx=$1

python3 scripts/bert_coref.py -m predict \
-w models/crossval/$idx.model \
-v data/litbank_tenfold_splits/$idx/test.conll \
-o preds/crossval/$idx.goldmentions.test.preds \
-s reference-coreference-scorers/scorer.pl
