#!/usr/bin/env bash

set -exu

idx=$1
partition=${2:-m40-short}
mem=${3:-12000}
threads=${4:-4}
gpus=${5:-1}

TIME=`(date +%Y-%m-%d-%H-%M-%S)`

export MKL_NUM_THREADS=$threads
export OPENBLAS_NUM_THREADS=$threads
export OMP_NUM_THREADS=$threads


dataset="litbank"
model_name="cross_val_train"
job_name="$model_name-$dataset-$TIME"
log_dir=logs/$model_name/$dataset/$TIME
log_base=$log_dir/$job_name
mkdir -p $log_dir

sbatch -J $job_name \
            -e $log_base.err \
            -o $log_base.log \
            --cpus-per-task $threads \
            --partition=$partition \
            --gres=gpu:$gpus \
            --ntasks=1 \
            --nodes=1 \
            --mem=$mem \
            --time=0-04:00 \
            bin/run_cross_val_train.sh $idx