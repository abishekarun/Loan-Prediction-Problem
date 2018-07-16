library(rpart)
library(caret)
library(mlbench)

total_data <- readRDS("total_data.rds")
train_target <- readRDS("train_target.rds")

train_data_imputed <- total_data[1:614,]
test_data_imputed <- total_data[615:981,]

# define the control using a random forest selection function
control <- rfeControl(functions=rfFuncs, method="cv", number=10)

# run the RFE algorithm
results <- rfe(train_data_imputed,train_target, sizes=c(1:6), rfeControl=control)

# summarize the results
print(results)
# list the chosen features
predictors(results)
# plot the results
plot(results, type=c("g", "o"))

seed <- 7
my_control <- trainControl(method='repeatedcv', number=10,repeats=3)
set.seed(seed)
model1 <- train(train_data_imputed,
                train_target,
                trControl=my_control,
                method="glm")

print(model1)

# estimate variable importance
importance <- varImp(model1, scale=FALSE)
# summarize importance
print(importance)
# plot importance
plot(importance)

test_pred1 <- predict(model1,test_data_imputed)

model2 <- train(train_data_imputed,
                train_target,
                trControl=my_control,
                method="C5.0",
                metric="Accuracy")

print(model2$results)

test_pred2 <- predict(model2,test_data_imputed)

model3 <- train(train_data_imputed,
                train_target,
                trControl=my_control,
                method="glm",
                metric="Accuracy")

print(model3$results)

test_pred3 <- predict(model3,test_data_imputed)

model4 <- train(train_data_imputed,
                train_target,
                trControl=my_control,
                method="knn",
                metric="Accuracy")

print(model4$results)

test_pred4 <- predict(model4,test_data_imputed)

model5<- train(train_data_imputed,
               train_target,
               trControl=my_control,
               method="svmRadial",
               metric="Accuracy")

print(model5$results)

test_pred5 <- predict(model5,test_data_imputed)

saveRDS(test_pred1,"test_pred1.rds")
saveRDS(test_pred2,"test_pred2.rds")
saveRDS(test_pred3,"test_pred3.rds")
saveRDS(test_pred4,"test_pred4.rds")
saveRDS(test_pred5,"test_pred5.rds")