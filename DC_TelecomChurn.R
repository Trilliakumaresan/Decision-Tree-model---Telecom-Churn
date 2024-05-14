install.packages("caTools")
library(caTools)
install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)
install.packages("caret")
library(caret)
library(dplyr)

data=read.csv("telecom_churn.csv")

set.seed(42)
sample_split <-sample.split(Y=data$Churn, SplitRatio = 0.75)
train_set <- subset(x=data, sample_split == TRUE)
test_set <- subset(x=data, sample_split == FALSE)

decisiontree_model <-rpart(Churn ~ ., data=train_set, method = "class")
decisiontree_model

rpart.plot(decisiontree_model)

importance <- varImp(decisiontree_model)
importance %>% arrange(desc(Overall))

preds <-predict(decisiontree_model, newdata = test_set, type ="class")
preds

levels(test_set$Churn)

levels(preds)

test_set$Churn <- factor(test_set$Churn, levels = levels(preds))

confusionMatrix(test_set$Churn, preds)
