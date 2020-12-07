Auto <- read.table("Auto.data", header=T, na.strings="?")
Auto <- na.omit(Auto)
attach(Auto)
high <- mpg >= 23
high <- high * 1

origin2 <- (origin == 2) * 1
origin3 <- (origin == 3) * 1
AutoX <- data.frame(horsepower,weight,year,origin2,origin3)
AutoY <- data.frame(high)

AutoX <- data.matrix(AutoX)
AutoY <- data.matrix(AutoY)

test_size = nrow(AutoX) * 0.5
set.seed(0415)
test_index <- sample(seq_len(nrow(AutoX)),size = test_size)
Auto.TrainX <- AutoX[-test_index,]
Auto.Trainy <- AutoY[-test_index]
Auto.TestX <- AutoX[test_index,]
Auto.Testy <- AutoY[test_index]

means = c()
for (i in 1:3) {
  means[i] <- mean(Auto.TrainX[,i])
}
stds = c()
for (i in 1:3) {
  stds[i] <- sd(Auto.TrainX[,i])
}
for (i in 1:3){
  Auto.TrainX[,i] = (Auto.TrainX[,i] - means[i])/stds[i]
  Auto.TestX[,i] = (Auto.TestX[,i] - means[i])/stds[i]
}

