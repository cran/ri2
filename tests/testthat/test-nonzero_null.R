context("Two Arm Trial")


test_that("Non zero null", {
  N <- 100
  declaration <- randomizr::declare_ra(N = N, m = 50)

  Z <- randomizr::conduct_ra(declaration)
  X <- rnorm(N)
  Y <- .9 * X + -1 * Z + rnorm(N)
  W <- runif(N)
  df <- data.frame(Y, X, Z, W)

  ri_out <-
    conduct_ri(
      formula = Y ~ Z,
      declaration = declaration,
      assignment = "Z",
      sharp_hypothesis = 0,
      data = df, sims = 100
    )

  plot(ri_out)
  summary(ri_out)


  ri_out <-
    conduct_ri(
      formula = Y ~ Z + X,
      declaration = declaration,
      assignment = "Z",
      sharp_hypothesis = -1,
      data = df, sims = 500
    )

  plot(ri_out)
  summary(ri_out)

  expect_true(TRUE)
})
