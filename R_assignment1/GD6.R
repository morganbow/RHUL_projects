p <- ncol(Auto.TrainX)
TestMSE <- c()
for (k in c(1:100)){
  beta <- runif((p+1), min=-0.7, max=0.7)
  for (i in 1:50) {
    beta <- gradient_descent(Auto.TrainX, Auto.Trainy, beta, eta=10^0)
    if (i == 50) {
      Testnew <- MSE_calc(Auto.TestX, Auto.Testy, beta)
      TestMSE <- append(TestMSE, Testnew)
    }
  }
}

boxplot(TestMSE, main="TestMSE with different initial beta's", ylab = "MSE", col = "red")

