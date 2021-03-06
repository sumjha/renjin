library(stats)
library(hamcrest)

test.css <- function() {

    lh <- structure(c(2.4, 2.4, 2.4, 2.2, 2.1, 1.5, 2.3, 2.3, 2.5, 2, 1.9,  1.7, 2.2, 1.8, 3.2, 3.2, 2.7, 2.2, 2.2, 1.9,
                    1.9, 1.8, 2.7, 3,  2.3, 2, 2, 2.9, 2.9, 2.7, 2.7, 2.3, 2.6, 2.4, 1.8, 1.7, 1.5,  1.4, 2.1, 3.3, 3.5,
                    3.5, 3.1, 2.6, 2.1, 3.4, 3, 2.9), .Tsp = c(1,  48, 1), class = "ts")


    fit <- arima(lh, order = c(3,0,0), method = "CSS")

    assertThat(fit$sigma2, closeTo(0.1904692, 1e-6))



    assertThat(arima(lh, order = c(1,0,0))$sigma2, closeTo(0.1975, 1e-3))
    assertThat(arima(lh, order = c(3,0,0))$sigma2, closeTo(0.1787, 1e-3))
    assertThat(arima(lh, order = c(1,0,1))$sigma2, closeTo(0.1923, 1e-3))

}


test.arima2 <- function() {

    WWWusage <- structure(c(
                    88, 84, 85, 85, 84, 85, 83, 85, 88, 89, 91, 99, 104, 112, 126, 138, 146, 151, 150, 148, 147,
                    149, 143, 132, 131, 139, 147, 150, 148, 145, 140, 134, 131, 131, 129, 126, 126, 132, 137, 140, 142, 150,
                    159, 167, 170, 171, 172, 172, 174, 175, 172, 172, 174, 174, 169, 165, 156, 142, 131, 121, 112, 104, 102,
                    99, 99, 95, 88, 84, 84, 87, 89, 88, 85, 86, 89, 91, 91, 94, 101, 110, 121, 135, 145, 149, 156, 165, 171,
                    175, 177, 182, 193, 204, 208, 210, 215, 222, 228, 226, 222, 220), class = "ts", .Tsp = c(1, 100, 1))
    arima(WWWusage, order=c(3,1,0))
}

test.forecast <- function() {

    presidents <- structure(c(NA, 87, 82, 75, 63, 50, 43, 32, 35, 60, 54, 55, 36,
                  39, NA, NA, 69, 57, 57, 51, 45, 37, 46, 39, 36, 24, 32, 23, 25,
                  32, NA, 32, 59, 74, 75, 60, 71, 61, 71, 57, 71, 68, 79, 73, 76,
                  71, 67, 75, 79, 62, 63, 57, 60, 49, 48, 52, 57, 62, 61, 66, 71,
                  62, 61, 57, 72, 83, 71, 78, 79, 71, 62, 74, 76, 64, 62, 57, 80,
                  73, 69, 69, 71, 64, 69, 62, 63, 46, 56, 44, 44, 52, 38, 46, 36,
                  49, 35, 44, 59, 65, 65, 56, 66, 53, 61, 52, 51, 48, 54, 49, 49,
                  61, NA, NA, 68, 44, 40, 27, 28, 25, 24, 24), .Tsp = c(1945, 1974.75,
                  4), class = "ts")

     fit <- arima(presidents, c(3, 0, 0))

     pr <- KalmanForecast(12, fit$model)

     assertThat(pr$pred, identicalTo(c(-26.3803105522721, -21.8121169472147,
                              -16.9140989870332, -13.1944650784283, -10.0341771912656, -7.65278117956026,
                              -5.77359495883928, -4.36161520782695, -3.27930727694887, -2.46704603431369,
                              -1.85205879207867, -1.39075218704266), tol = 1e6))



     assertThat(pr$var, identicalTo(c(1, 1.56191085317941,
                             2.22477915769554, 2.59732733722627, 2.86899258401796, 3.02169563380432,
                             3.11719330233226, 3.17087706096914, 3.20247847892449, 3.22024401572767,
                             3.23043656267706, 3.2361667223572), tol = 1e6))


}

