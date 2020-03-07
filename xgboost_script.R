install.packages("drat", repos="https://cran.rstudio.com")
drat:::addRepo("dmlc")
install.packages("xgboost", repos="http://dmlc.ml/drat/", type = "source")
require(xgboost)
install.packages("xgboost",dependencies = T)
# train and test data
library(xgboost)

data(agaricus.train, package='xgboost')
data(agaricus.test, package='xgboost')
train <- agaricus.train
test <- agaricus.test
str(train)
# Let's discover the dimensionality of our datasets.
dim(train$data)
dim(test$data)
class(train$data)[1] #gives the class of the training data
class(train$label) # gives the labels of the data

#Basic Training using XGBoost
#We will train decision tree model using the following parameters:
#objective = "binary:logistic": we will train a binary classification model ;
#max.depth = 2: the trees won't be deep, because our case is very simple ;
#nthread = 2: the number of cpu threads we are going to use;
#nrounds = 2: there will be two passes on the data, the second one will enhance the model by further reducing the difference between ground truth and prediction.

bstSparse <- xgboost(data = train$data, label = train$label, max.depth = 2, eta = 1, nthread = 4, nrounds = 2, objective = "binary:logistic")

dtrain <- xgb.DMatrix(data = train$data, label = train$label)
bstDMatrix <- xgboost(data = dtrain, max.depth = 2, eta = 1, nthread = 2, nrounds = 2, objective = "binary:logistic")
# verbose = 1, print evaluation metric
bst <- xgboost(data = dtrain, max.depth = 2, eta = 1, nthread = 2, nrounds = 2, objective = "binary:logistic", verbose = 1)

#Basic prediction using XGBoost, The purpose of the model we have built is to classify new data
pred <- predict(bst, test$data)
# size of the prediction vector
print(length(pred))
# limit display of predictions to the first 10
print(head(pred))

#Transform the regression in a binary classification
prediction <- as.numeric(pred > 0.5)
print(head(prediction))

#Measuring model performance
#To measure the model performance, we will compute a simple metric, the average error
err <- mean(as.numeric(pred > 0.5) != test$label)
print(paste("test-error=", err))

#Understanding my data
setwd("C:/Users/oknjav001/Desktop/xboost_classification")
ms_peaks <- read.table("javan_clemsns_27_balSamples.txt",header = T, sep = '\t')
dim(ms_peaks)

require(xgboost)
require(Matrix)
require(data.table)
if (!require('vcd')) install.packages('vcd')

head(ms_peaks) # give an insight of the first few lines on the data
str(ms_peaks) # Now we will check the format of each column



















