# renv::install("bench")
n_size <- 10000
df1 <- data.frame(date = as.Date(numeric(0), origin = "1970-01-01"), value = integer(0))
df2 <- data.frame(date = as.Date(numeric(n_size), origin = "1970-01-01"), value = integer(n_size))
df3 <- data.frame(date = as.Date(numeric(n_size), origin = "1970-01-01"), value = integer(n_size))

# case 1
system.time({
  for (i in 1:n_size) {
    df1[i, "date"] <- sample(x = seq.Date(as.Date("2000-01-01"), as.Date("2019-12-31"), "day"), size = 1)
    df1[i, "value"] <- sample(1:10^7, size = 1)
  }
})

# case 2
system.time({
  for (i in 1:n_size) {
    df2[i, "date"] <- sample(x = seq.Date(as.Date("2000-01-01"), as.Date("2019-12-31"), "day"), size = 1)
    df2[i, "value"] <- sample(1:10^7, size = 1)
  }
})

# case 3
system.time({
  df3$date <- sample(x = seq.Date(as.Date("2000-01-01"), as.Date("2019-12-31"), "day"), size = nrow(df3), replace = TRUE)
  df3$value <- sample(1:10^7, size = nrow(df3), replace = TRUE)
})


x <- 1:100000
y <- 1:100000

bench::mark(
  iterative = {x <- 1:100000; for (i in seq_along(x)) x[i] <- x[i] + 1},
  vectorised = {y <- 1:100000; y <- y + 1},
  check = FALSE
)

