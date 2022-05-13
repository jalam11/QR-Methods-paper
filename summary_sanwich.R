
summary_sandwich <- function(object, n, covariates= x, burnin = 1, level = 0.95) {

  z <- qnorm( 1 - ((1-level) / 2) )
  
  tau <- object[[1]]$quantile

  D1.m1 <- sqrt(n)*var(object[[1]]$beta[-(1:burnin),])/1  # from page 331 of Yang. "D1.m1" means "D1 to the minus 1; which is the inverse of D1"
  # X <- cbind(1, covariates)  ## build an object called "X", which is required
  X <- covariates
  D0 <- (1/n)*(t(X) %*% X) # from page 331 of Yang
  
  tmp <- sqrt(diag( tau*(1-tau) * ((D1.m1 %*% D0) %*% D1.m1))) #rows of right matrix must = # of columns of left matrix
  
  mn <- mean(object[[1]]$beta[-(burnin),2])  # regression coefficient for chemical (posterior mean)
  se.adj <- tmp[2]
  lower_bound <- mn - se.adj*z
  upper_bound <- mn + se.adj*z
  
  res <- c(mn, lower_bound, upper_bound)
  return(res)
}


summary_sw <- function(object, n, covariates= x, burnin = 1, level = 0.95) {
  
  z <- qnorm( 1 - ((1-level) / 2) )
  
  tau <- object[[1]]$quantile
  
  D1.m1 <- sqrt(n)*var(object[[1]]$beta[-(1:burnin),])/1  # from page 331 of Yang. "D1.m1" means "D1 to the minus 1; which is the inverse of D1"
  # X <- cbind(1, covariates)  ## build an object called "X", which is required
  X <- covariates
  D0 <- (1/n)*(t(X) %*% X) # from page 331 of Yang
  
  tmp <- sqrt(diag( tau*(1-tau) * ((D1.m1 %*% D0) %*% D1.m1))) #rows of right matrix must = # of columns of left matrix
  
  mn <- mean(object[[1]]$beta[-(burnin),2])  # regression coefficient for chemical (posterior mean)
  se.adj <- tmp[2]
  lower_bound <- mn - se.adj*z
  upper_bound <- mn + se.adj*z
  
  res <- c(mn, lower_bound, upper_bound)
  return(res)
}

