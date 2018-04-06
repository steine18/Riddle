library(dplyr)


days <- function(m,y){
  # Takes month and year as arguments, returns
  
  d <- list('1' = 31,
            '3' = 31, 
            '4' = 30,
            '5' = 31,
            '6' = 30,
            '7' = 31,
            '8' = 31,
            '9' = 30,
            '10' = 31,
            '11' = 30,
            '12' = 31)
  if (m != 2 & m >= 1 & m <= 12){
    return(d[[as.character(m)]])
  }else if(m == 2){
    if (y %in% seq(0,99, by = 4)){
      return(29)
    }else{return(28)}
  }
}

results <- data.frame(matrix(data = NA, nrow = 0, ncol = 3))
names(results) <- c("day", "month", "year")
for(y in seq(1,99)){
  for(m in seq(1,12)){
    d <- days(m,y)
    if(y/m <= d & y%%m == 0){
      temp <- data.frame(day = y/m,
                         month = m,
                         year = y)
      results <- bind_rows(results, temp)
    }
  }
}


total <- nrow(results)

sum_results <- group_by(results, year) %>% summarise(n = n())
most <- sum_results[sum_results$n == max(sum_results$n),]$year + 2000
least <- sum_results[sum_results$n == min(sum_results$n),]$year + 2000
none <- subset(seq(1,99), !(seq(1,99) %in% sum_results$year))

results$date <- as.Date(paste(as.character(results$year + 2000), as.character(results$month), as.character(results$day), sep="-"))

results$diff <- NA
for (i in seq(2,nrow(results))){
  results[i,'diff'] <- results$date[i] - results$date[i - 1] 
  
}
