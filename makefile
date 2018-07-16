## one Makefile to make them all

all: submission.csv

%.rds:Input_data/train_u6lujuX_CVtuZ9i.csv Input_data/test_Y3wMUE5_7gLdaTN.csv 1_data_cleaning.R
	Rscript 1_data_cleaning.R
	Rscript 2_eda.R

total_data_mod.rds: total_data_coded.rds 3_feature_engineering.R
	Rscript 3_feature_engineering.R

total_data.rds: total_data_mod.rds 4_feature_selection.R
	Rscript 4_feature_selection.R

test_pred1.rds: total_data.rds train_target.rds 5_train.R
	Rscript 5_train.R

submission.csv: test_pred1.rds test_pred2.rds test_pred3.rds test_pred4.rds test_pred5.rds 6_ensemble.R
	Rscript 6_ensemble.R

GARBAGE_TYPES         := *.rds *.pdf 

clean:
	rm $(GARBAGE_TYPES)