################################################################################
##
##   R package heart by Haoda Fu, Jun Yan, and Wenjie Wang
##   Copyright (C) 2015
##
##   This file is part of the R package heart.
##
##   The R package heart is free software: you can redistribute it and/or
##   modify it under the terms of the GNU General Public License as published
##   by the Free Software Foundation, either version 3 of the License, or
##   (at your option) any later version.
##
##   The R package heart is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
##
##   You should have received a copy of the GNU General Public License
##   along with the R package heart. If not, see <http://www.gnu.org/licenses/>.
##
################################################################################

#' \code{show} prints heart objects.
#'  
#' S4 class function to print \code{heart} objects 
#' generated from function \code{heart}.
#' 
#' The contents printed by this function \code{show} is
#' a brief summary of the \code{heart} object.
#' 
#' @param object object from class \code{heart}
#' @seealso \code{\link[heart]{heart}}
#' @export
setMethod(f = "show", signature = "heart",
          definition = function(object) {
            beta <- round(object@estimates$beta[, "coef"], digits = 3)
            names(beta) <- rownames(object@estimates$beta)
            theta <- round(object@estimates$theta[, "theta"], digits = 3)
            names(theta) <- NULL
            alpha <- round(object@estimates$alpha[, "alpha"], digits = 3)
            names(alpha) <- rownames(object@estimates$alpha)
            cat("\ncall: \n")
            print(object@call)
            cat("\nbaseline pieces: \n")
            cat(attr(object@baselinepieces, "name"), "\n")
            cat("\ncoefficients: \n") 
            print(beta)
            cat("\ntheta: ", theta, "\n")
            cat("\nbaseline rate functions: \n")
            print(alpha)
          })

#' \code{show} prints summary.heart objects.
#'  
#' S4 class function to print \code{summary.heart} objects 
#' generated from function \code{summary}.
#' 
#' The contents printed by this function \code{show} is
#' a summary of the \code{summary.heart} object.
#' 
#' @param object object from class \code{summary.heart}
#' @seealso \code{\link[heart]{heart}}, \code{\link[heart]{summary}}, 
#' @export
setMethod(f = "show", signature = "summary.heart",
          definition = function(object) {
            if (attr(object@call, "show")) {
              Call <- object@call
              attr(Call, "show") <- NULL
              cat("\ncall: \n")
              print(Call)
            }
            if (attr(object@baselinepieces, "show")) {
              cat("\nbaseline pieces: \n")
              cat(attr(object@baselinepieces, "name"), "\n")
            }
            cat("\ncoefficients: \n") 
            printCoefmat(object@coefficients)
            theta <- as.data.frame(object@theta)
            cat("\ntheta: \n")
            print(theta, row.names = FALSE)
            cat("\nbaseline rate functions: \n")
            print(object@baseline)
          })