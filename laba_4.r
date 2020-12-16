#install.packages("RClickhouse")
# Подключаемся к базе данных с помощью пакета RClickhouse
con <- DBI::dbConnect(RClickhouse::clickhouse(), host="",port=9000, password = "")
# Загружаем данные из таблицы при помощи функции dbGetQuery
res <- DBI::dbGetQuery(con, "SELECT * from db_11962.iris_11962")
print(res)
#install.packages("caret")
#install.packages("e1071")
# Пакет для работы с алгоритмами машинного обучения
library(caret)
library(e1071)
# Загрузим данные и создадим ссылку на него в переменную
dataset <- res
# Преобразим данные в корректные типы с помощью функций преобразования типов
dataset$Class <- factor(c("Iris-setosa","Iris-versicolor","Iris-virginica"))
# Узнаем как устроен массив данных
summary(dataset)
# Измерения
dim(dataset)
# Список типов каждого атрибута
sapply(dataset, class)
# Смотрим на данные
head(dataset)
# Просмотрим уровни классификатора
levels(dataset$Class)
# Распределение видов
percentage <- prop.table(table(dataset$Class)) * 100
cbind(freq = table(dataset$Class), percentage = percentage)
# Разобъем данные на переменные и отклик (x и y) 
x <- dataset[,1:4]
y <- dataset[,5]
# Диаграмма размаха
par(mfrow = c(1,4))
for(i in 1:4){
  boxplot(x[,i], main = names(iris)[i])
}
#featurePlot(x=x, y=y, plot="ellipse")
# Просмотрим взаимодействие внутри данных
featurePlot(x=x, y=y, plot="box")
# Будем запускать все алгоритмы и проверять кроссвалидацией (cv) через 10 блоков
control <- trainControl(method="cv", number=10)
# Контролируемая метрика
metric <- "Accuracy"
# Линейные алгоритмы (LDA)
set.seed(13)
fit.lda <- train(Class~., data=dataset, method="lda", metric=metric, trControl=control)
# Нелинейные алгоритмы (CART)
set.seed(13)
fit.cart <- train(Class~., data=dataset, method="rpart", metric=metric, trControl=control)
# kNN
set.seed (13)
fit.knn <- train(Class~., data=dataset, method="knn", metric=metric, trControl=control)
# Сложные алгоритмы (SVM)
set.seed(13)
fit.svm <- train(Class~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# RandomForest
set.seed(13)
fit.rf <- train(Class~., data=dataset, method="rf", metric=metric, trControl=control)
# Получим оценки контролируемой метрики для каждого алгоритма
results <- resamples(list(lda =fit.lda, cart = fit.cart, knn = fit.knn, svm = fit.svm, rf = fit.rf))
summary(results)
# Лучше всех RandomForest
print(fit.rf)
# Отрежем часть данных для последующей валидации. Получим 80% данных 
validation_index <- createDataPartition(dataset$Class, p =0.80, list=FALSE)
# Выберем 20% для валидации
validation <- dataset[-validation_index,]
# 80% будут исходные данные
dataset <- dataset[validation_index,]
predictions <- predict(fit.rf, validation)
confusionMatrix(predictions, validation$Class)
