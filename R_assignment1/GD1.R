gradient_descent <- function(X,Y, beta, eta) {
  
  n = nrow(X)
  p = ncol(X)
  
  ones <- matrix(rep(1,nrow(X)),ncol=1)
  X <- cbind(ones, X)
  
  P <- c()
  for (i in 1:n){
    newP <- (exp(beta[1] + t(matrix(beta[2:(p+1)])) %*% matrix(X[i,2:(p+1)])))/(1 + (exp(beta[1] + t(matrix(beta[2:(p+1)])) %*% matrix(X[i,2:(p+1)]))))
    P[i] <- newP
  }
  
  
  dsig <- c()
  for (i in 1:n){
    dsigP <- (exp(beta[1] + t(matrix(beta[2:(p+1)])) %*% matrix(X[i,2:(p+1)])))/(1 + (exp(beta[1] + t(matrix(beta[2:(p+1)])) %*% matrix(X[i,2:(p+1)]))))
    dsig[i] <- dsigP
    
  }
  
  d <- (2*(Y-P)) * dsig
  
  
  beta = beta + (eta/n) * t(matrix(d)) %*% X
  return (beta)
}