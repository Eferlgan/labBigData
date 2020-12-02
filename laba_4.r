#install.packages("RClickhouse")

con <- DBI::dbConnect(RClickhouse::clickhouse(), host="",port=9000, password = "")
res <- DBI::dbGetQuery(con, "SELECT * from db_11962.iris_11962")
print(res)
#install.packages("caret")
#install.packages("e1071")
library(caret)
library(e1071)
dataset <- res
dataset$Class <- factor(c("Iris-setosa","Iris-versicolor","Iris-virginica"))
summary(dataset)
dim(dataset)
sapply(dataset, class)
head(dataset)
levels(dataset$Class)
percentage <- prop.table(table(dataset$Class)) * 100
cbind(freq = table(dataset$Class), percentage = percentage)
x <- dataset[,1:4]
y <- dataset[,5]
par(mfrow = c(1,4))
for(i in 1:4){
  boxplot(x[,i], main = names(iris)[i])
}
#featurePlot(x=x, y=y, plot="ellipse")
featurePlot(x=x, y=y, plot="box")
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"
set.seed(13)
fit.lda <- train(Class~., data=dataset, method="lda", metric=metric, trControl=control)
set.seed(13)
fit.cart <- train(Class~., data=dataset, method="rpart", metric=metric, trControl=control)
set.seed (13)
fit.knn <- train(Class~., data=dataset, method="knn", metric=metric, trControl=control)
set.seed(13)
fit.svm <- train(Class~., data=dataset, method="svmRadial", metric=metric, trControl=control)
set.seed(13)
fit.rf <- train(Class~., data=dataset, method="rf", metric=metric, trControl=control)
results <- resamples(list(lda =fit.lda, cart = fit.cart, knn = fit.knn, svm = fit.svm, rf = fit.rf))
summary(results)
print(fit.rf)
validation_index <- createDataPartition(dataset$Class, p =0.80, list=FALSE)
validation <- dataset[-validation_index,]
dataset <- dataset[validation_index,]
predictions <- predict(fit.rf, validation)
confusionMatrix(predictions, validation$Class)
