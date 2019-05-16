female_factors <- read.csv('data/female_age_factors.csv', header = TRUE, stringsAsFactors = FALSE)
colnames(female_factors) <- female_factors[1, ]
female_factors <- female_factors[-1, ]

times_5k <- c(15:45)
factors_5k <- female_factors[, c('Age', '5 km')]
factors_5k <- factors_5k[-c(1:3, 65:70), ]
class(factors_5k$`5 km`) <- "numeric"
factor_times_5k <- t(replicate(nrow(factors_5k), times_5k))
k <- as.data.frame(factor_times_5k*rep(factors_5k$`5 km`, ncol(factor_times_5k)))
k2 <- cbind(factors_5k, k)
colnames(k2) <- c("Age", "factor", 15:45)
