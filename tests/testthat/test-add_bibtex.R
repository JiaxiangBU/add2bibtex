test_that("add_bibtex works", {
  expect_that(add_bibtex("book"), prints_text())
  expect_that(add_bibtex("manual"), prints_text())
  expect_that(add_bibtex("online"), prints_text())
  expect_that(add_bibtex("more"), prints_text())
})
test_that("add_datacamp works", {
  expect_that(add_datacamp("https://www.datacamp.com/courses/extreme-gradient-boosting-with-xgboost"),
              prints_text())
})
test_that("add_kaggle works", {
  expect_that(add_kaggle("https://www.kaggle.com/lijiaxiang/stacking"), prints_text())
})
test_that("add_wechat works", {
  expect_that(add_wechat("https://mp.weixin.qq.com/s/2-1taZ5o4uzVcGMe5u4P-A"), prints_text())
})
