#!/usr/bin/env bash

kaggle competitions download -c house-prices-advanced-regression-techniques -p packages/regression_model/regression_model/datasets/

#2. unzip the downloaded folder
unzip  packages/regression_model/regression_model/datasets/house-prices-advanced-regression-techniques.zip

#3. pick only the interested files and put them in the package dataset
mv train.csv  packages/regression_model/regression_model/datasets/
mv test.csv  packages/regression_model/regression_model/datasets/
