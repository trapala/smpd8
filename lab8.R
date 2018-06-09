#install.packages("rpart")
#install.packages("dplyr")
#install.packages("party")
library("rpart")
library("dplyr")
library("party")
data <- as.data.frame(matrix(c(27.6, 26.2, 19.6, 19.2, 20.6, 22.8, 18.8, 27.9, 20.6, 24.6, 10.0, 21.0, 21.2, 36.1, 16.6,
                               130, 98, 75, 98, 98, 111, 98, 87, 98, 98, 56, 98, 98, 211, 64,
                               17, 18, 28, 21, 24, 24, 20, 16, 24, 16, 20, 20, 18, 12, 19,
                               3399, 2099, 899, 1399, 1799, 1199, 1699, 1999, 2199, 2099, 890, 1899, 1799, 3449, 1198), 15, 4))
labels <- c("1", "2", "3", "4", "5")
result <- c(2, 3, 4, 4, 3, 4, 4, 3, 3, 4, 3, 3, 4, 2, 3)
factors <- factor(result, labels)
data <- cbind(data, factors)
colnames(data) <- c("Matryca", "JasnoscEkranu", "CzasReakcjiMatrycy", "Cena", "Ocena")

mydata <- c("training", "test") %>% sample(nrow(data), replace=T) %>% split(data, .)
rtree_fit <- rpart(Ocena ~ ., mydata$training, control=rpart.control(minsplit=1, minbucket=1, cp=0.001))
par(mar = rep(0.2, 4))
plot(rtree_fit, uniform = TRUE)
text(rtree_fit, use.n = TRUE)