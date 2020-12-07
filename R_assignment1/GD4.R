MSE_calc <- function(X,Y,beta) {
  n = nrow(X)
  p = ncol(X)
  ones <- matrix(rep(1,nrow(X)),ncol=1)
  X <- cbind(ones, X)
  testP <- c()
  for (i in 1:n){
    newtestP <- (exp(beta[1] + t(matrix(beta[2:(p+1)])) %*% matrix(X[i,2:(p+1)])))/(1 + (exp(beta[1] + t(matrix(beta[2:(p+1)])) %*% matrix(X[i,2:(p+1)]))))
    testP[i] <- newtestP
  }
  MSE <- sum((Y-testP)^2)/n
  return (MSE)
}


p <- ncol(Auto.TrainX)
TestMSE <- c()
TrainingMSE <- c()
for (k in c(2,1,0)){
  set.seed(0415)
  beta <- runif((p+1), min=-0.7, max=0.7)
  for (i in 1:1000) {
    beta <- gradient_descent(Auto.TrainX, Auto.Trainy, beta, eta=10^-k)
    Trainingnew <- MSE_calc(Auto.TrainX, Auto.Trainy, beta)
    Testnew <- MSE_calc(Auto.TestX, Auto.Testy, beta)
    TestMSE <- append(TestMSE, Testnew)
    TrainingMSE <- append(TrainingMSE, Trainingnew)
    
  }
}
TestMSE <- matrix(TestMSE, nrow=3, ncol=1000, byrow=TRUE)

TestMSE <- TestMSE[,c(1,2,4,10,20,50,100,200,500,1000)]

colnames(TestMSE) <- c(1,2,4,10,20,50,100,200,500,1000)
rownames(TestMSE) <- c(0.01, 0.1, 1)
TestMSE <- as.data.frame(TestMSE)

TrainingMSE <- matrix(TrainingMSE, nrow=3, ncol=1000, byrow=TRUE)

TrainingMSE <- TrainingMSE[,c(1,2,4,10,20,50,100,200,500,1000)]

colnames(TrainingMSE) <- c(1,2,4,10,20,50,100,200,500,1000)
rownames(TrainingMSE) <- c(0.01, 0.1, 1)
TrainingMSE <- as.data.frame(TrainingMSE)