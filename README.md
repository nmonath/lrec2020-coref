# lrec20202-coref

Code and data to support Bamman, Lewke and Mansoor (2020), "A Dataset of Literary Coreference" (LREC).

### Setup

```sh
sh bin/make_env.sh
```

### Create 10-fold cross-validation data

```sh
python scripts/create_crossval.py data/litbank_tenfold_splits data/original/conll/  data/litbank_tenfold_splits

mkdir -p models/crossval
mkdir -p preds/crossval
mkdir -p logs/crossval
```

### Download benchmark coreference scorers

```
git clone https://github.com/conll/reference-coreference-scorers
```

### Generate cross-validation training and prediction script

```sh
SCORER=reference-coreference-scorers/scorer.pl
python scripts/create_crossval_train_predict.py $SCORER scripts/crossval-train.sh scripts/crossval-predict.sh
chmod 755 scripts/crossval-train.sh
chmod 755 scripts/crossval-predict.sh

```

### Train 10 models (each on their own training partition)

```sh
for i in {0..9}
do
sh bin/launch_cross_val_train.sh $i
done
```

### Use each trained model to make predictions for its own held-out test data.

```sh
./scripts/crossval-predict.sh
cat preds/crossval/{0,1,2,3,4,5,6,7,8,9}.goldmentions.test.preds > preds/crossval/all.goldmentions.test.preds
```

### Evaluate

```sh
python scripts/calc_coref_metrics.py data/original/conll/all.conll preds/crossval/all.goldmentions.test.preds $SCORER
```





