#!/usr/bin/env bash

set -exu

SCORER=reference-coreference-scorers/scorer.pl
python scripts/create_crossval_train_predict.py $SCORER scripts/crossval-train.sh scripts/crossval-predict.sh
chmod 755 scripts/crossval-train.sh
chmod 755 scripts/crossval-predict.sh