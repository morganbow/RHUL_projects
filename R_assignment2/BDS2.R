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


nu = 0.01
B=1
test.pred <- matrix(0,1,length(Boston.Testy))
while (B<1001) {
  s.lstat <- seq(from=min(Boston.TrainX$lstat)+0.1, to=max(Boston.TrainX$lstat)-0.1, by=0.1)
  
  RSS.lstat <- c() 
  s.lstat.lessthan.ave <- c()
  s.lstat.greaterthan.ave <- c()
  for (i in 1:length(s.lstat)) {
    s.lstat.lessthan.ave[i] <- sum(Boston.Trainy[Boston.TrainX$lstat < s.lstat[i]])/length(Boston.Trainy[Boston.TrainX$lstat < s.lstat[i]])
    s.lstat.greaterthan.ave[i] <- sum(Boston.Trainy[Boston.TrainX$lstat >= s.lstat[i]])/length(Boston.Trainy[Boston.TrainX$lstat >= s.lstat[i]])
    
    RSS.lstat[i] = sum((Boston.Trainy[Boston.TrainX$lstat < s.lstat[i]]-s.lstat.lessthan.ave[i])^2) + sum((Boston.Trainy[Boston.TrainX$lstat >= s.lstat[i]]-s.lstat.greaterthan.ave[i])^2)
  }
  
  min.lstat <- min(RSS.lstat)
  
  
  s.rm <- seq(from=min(Boston.TrainX$rm)+0.1, to=max(Boston.TrainX$rm)-0.1, by=0.1)
  
  RSS.rm <- c() 
  s.rm.lessthan.ave <- c()
  s.rm.greaterthan.ave <- c()
  for (i in 1:length(s.rm)) {
    s.rm.lessthan.ave[i] <- sum(Boston.Trainy[Boston.TrainX$rm < s.rm[i]])/length(Boston.Trainy[Boston.TrainX$rm < s.rm[i]])
    s.rm.greaterthan.ave[i] <- sum(Boston.Trainy[Boston.TrainX$rm >= s.rm[i]])/length(Boston.Trainy[Boston.TrainX$rm >= s.rm[i]])
    
    RSS.rm[i] = sum((Boston.Trainy[Boston.TrainX$rm < s.rm[i]]-s.rm.lessthan.ave[i])^2) + sum((Boston.Trainy[Boston.TrainX$rm >= s.rm[i]]-s.rm.greaterthan.ave[i])^2)
  }
  min.rm <- min(RSS.rm)
  
  if (min.rm<min.lstat){
    split <- min(s.rm[RSS.rm==min(RSS.rm)])
    for (i in 1:nrow(Boston.TrainX)){
      if  (Boston.TrainX$rm[i] < split){
        Boston.Trainy[i] <- Boston.Trainy[i] - nu * min(s.rm.lessthan.ave[RSS.rm==min(RSS.rm)])
      }
      else{
        Boston.Trainy[i] <- Boston.Trainy[i] - min(nu * s.rm.greaterthan.ave[RSS.rm==min(RSS.rm)])
      }
      
    } 
    
    for (j in 1:length(test.pred)){
      if (Boston.TestX$rm[j] < split){
        test.pred[j] <- test.pred[j] + nu * min(s.rm.lessthan.ave[RSS.rm==min(RSS.rm)])
      }
      else{
        test.pred[j] <- test.pred[j] + min(nu * s.rm.greaterthan.ave[RSS.rm==min(RSS.rm)])
      }
    }
  }
  else{
    split <- min(s.lstat[RSS.lstat==min(RSS.lstat)])
    for (i in 1:nrow(Boston.TrainX)){
      if  (Boston.TrainX$lstat[i] < split){
        Boston.Trainy[i] <- Boston.Trainy[i] - nu * min(s.lstat.lessthan.ave[RSS.lstat==min(RSS.lstat)])
      }
      else{
        Boston.Trainy[i] <- Boston.Trainy[i] - nu * min(s.lstat.greaterthan.ave[RSS.lstat==min(RSS.lstat)])
      }
      
    }
    
    for (j in 1:length(test.pred)){
      if (Boston.TestX$lstat[j] < split){
        test.pred[j] <- test.pred[j] + nu * min(s.lstat.lessthan.ave[RSS.lstat==min(RSS.lstat)])
      }
      else{
        test.pred[j] <- test.pred[j] + min(nu * s.lstat.greaterthan.ave[RSS.lstat==min(RSS.lstat)])
      }
    }
  }
  B = B + 1
  
}

Test.MSE <- sum((Boston.Testy-test.pred)^2)/length(Boston.Testy)
print(Test.MSE)
