library(blockForest)
library(survival)
context("blockForest_extratrees")

test_that("extratrees splitting works for classification", {
  rf <- blockForest(Species ~ ., iris, splitrule = "extratrees")
  expect_is(rf, "blockForest")
  expect_lt(rf$prediction.error, 0.2)
})

test_that("extratrees unordered splitting works for classification", {
  n <- 20
  dat <- data.frame(x = sample(c("A", "B", "C", "D"), n, replace = TRUE), 
                    y = factor(rbinom(n, 1, 0.5)), 
                    stringsAsFactors = FALSE)
  rf <- blockForest(y ~ ., data = dat, num.trees = 5, min.node.size = n/2, 
               splitrule = "extratrees", respect.unordered.factors = 'partition')
  
  expect_is(rf, "blockForest")
})

test_that("extratrees splitting works for probability estimation", {
  rf <- blockForest(Species ~ ., iris, probability = TRUE, splitrule = "extratrees")
  expect_is(rf, "blockForest")
  expect_lt(rf$prediction.error, 0.2)
})

test_that("extratrees unordered splitting works for probability estimation", {
  n <- 20
  dat <- data.frame(x = sample(c("A", "B", "C", "D"), n, replace = TRUE), 
                    y = factor(rbinom(n, 1, 0.5)), 
                    stringsAsFactors = FALSE)
  rf <- blockForest(y ~ ., data = dat, num.trees = 5, min.node.size = n/2, 
               splitrule = "extratrees", respect.unordered.factors = 'partition', 
               probability = TRUE)
  expect_is(rf, "blockForest")
})

test_that("extratrees splitting works for regression", {
  rf <- blockForest(Sepal.Length ~ ., iris, splitrule = "extratrees")
  expect_is(rf, "blockForest")
  expect_gt(rf$r.squared, 0.5)
})

test_that("extratrees unordered splitting works for regression", {
  rf <- blockForest(Sepal.Length ~ ., iris, splitrule = "extratrees", respect.unordered.factors = "partition")
  expect_is(rf, "blockForest")
  expect_gt(rf$r.squared, 0.5)
})

test_that("extratrees splitting works for survival", {
  rf <- blockForest(Surv(time, status) ~ ., veteran, splitrule = "extratrees")
  expect_is(rf, "blockForest")
  expect_lt(rf$prediction.error, 0.4)
})

test_that("extratrees unordered splitting works for survival", {
  rf <- blockForest(Surv(time, status) ~ ., veteran, splitrule = "extratrees", respect.unordered.factors = "partition")
  expect_is(rf, "blockForest")
  expect_lt(rf$prediction.error, 0.4)
})

test_that("extratrees splitting works for large number of random splits", {
  expect_silent(blockForest(Species ~ ., iris, splitrule = "extratrees", num.random.splits = 100))
})
