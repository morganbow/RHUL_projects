#Splitting the data 
library(MASS)
attach(Boston)
Boston.X <- data.frame(lstat,rm)
test_size = nrow(Boston.X) * 0.5
set.seed(0415)
test_index <- sample(seq_len(nrow(Boston.X)),size = test_size)
Boston.TrainX <- Boston.X[-test_index,]
Boston.Trainy <- medv[-test_index]
Boston.TestX <- Boston.X[test_index,]
Boston.Testy <- medv[test_index]



#Finding the best split for lstat
s.lstat <- seq(from=min(Boston.TrainX$lstat)+0.1, to=max(Boston.TrainX$lstat)-0.1, by=0.1)


RSS.lstat <- c() 
s.lstat.lessthan.ave <- c()
s.lstat.greaterthan.ave <- c()
for (i in 1:length(s.lstat)) {
  s.lstat.lessthan.ave[i] <- sum(Boston.Trainy[Boston.TrainX$lstat < s.lstat[i]])/sum(Boston.TrainX$lstat < s.lstat[i])
  s.lstat.greaterthan.ave[i] <- sum(Boston.Trainy[Boston.TrainX$lstat >= s.lstat[i]])/sum(Boston.TrainX$lstat >= s.lstat[i])

  RSS.lstat[i] = sum((Boston.Trainy[Boston.TrainX$lstat < s.lstat[i]]-s.lstat.lessthan.ave[i])^2) + sum((Boston.Trainy[Boston.TrainX$lstat >= s.lstat[i]]-s.lstat.greaterthan.ave[i])^2)
}
par(mfrow=c(1,2))
plot(s.lstat,RSS.lstat, type="l",main="RSS for different splits of lstat",xlab="split",ylab="RSS", col="red")
min(RSS.lstat)
s.lstat[RSS.lstat==min(RSS.lstat)]


#Finding the best split for rm
s.rm <- seq(from=min(Boston.TrainX$rm)+0.1, to=max(Boston.TrainX$rm)-0.1, by=0.1)


RSS.rm <- c() 
s.rm.lessthan.ave <- c()
s.rm.greaterthan.ave <- c()
for (i in 1:length(s.rm)) {
  s.rm.lessthan.ave[i] <- sum(Boston.Trainy[Boston.TrainX$rm < s.rm[i]])/length(Boston.Trainy[Boston.TrainX$rm < s.rm[i]])
  s.rm.greaterthan.ave[i] <- sum(Boston.Trainy[Boston.TrainX$rm >= s.rm[i]])/length(Boston.Trainy[Boston.TrainX$rm >= s.rm[i]])
  
  RSS.rm[i] = sum((Boston.Trainy[Boston.TrainX$rm < s.rm[i]]-s.rm.lessthan.ave[i])^2) + sum((Boston.Trainy[Boston.TrainX$rm >= s.rm[i]]-s.rm.greaterthan.ave[i])^2)
}

plot(s.rm,RSS.rm, type="l",main="RSS for different splits of rm",xlab="split",ylab="",col="green")
min(RSS.rm)
train.MSE <- min(RSS.rm)/nrow(Boston.TrainX)

#rm split had the lower RSS so this will be used to find the test MSE

split <- s.rm[RSS.rm==min(RSS.rm)]
test.lessthan = 0
test.greterthan = 0
for (i in 1:nrow(Boston.TestX)){
  if (Boston.TestX$rm[i] < split){
    test.lessthan <- test.lessthan + (Boston.Testy[i]-s.rm.lessthan.ave[RSS.rm==min(RSS.rm)])^2
  }
  else{
    test.greterthan <- test.greterthan + (Boston.Testy[i]-s.rm.greaterthan.ave[RSS.rm==min(RSS.rm)])^2
  }
}

test.MSE <- (test.lessthan + test.greterthan)/nrow(Boston.TestX)
print(test.MSE)
