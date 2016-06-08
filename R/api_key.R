#' Fetch the Stripe API key
#'
#' Looks in the environmental variable STRIPE_API_KEY.  
#' Function adapted from \code{github_pat()} in \code{package::devtools}.
#' 
#' @param quiet Defaults to FALSE.  Can be set using the R option \code{stripe.quiet}
#'
#' @return \code{character} The API key
#' @export
#'
#' @examples
#' stripe_api_key()
stripe_api_key <- function (quiet = getOption("stripe.quiet", FALSE)) 
{
    stripe_api_key <- Sys.getenv("STRIPE_API_KEY")
    if (nzchar(stripe_api_key)) {
        if (!quiet) {
            message("Using Stripe API Key PAT from envvar STRIPE_API_KEY")
        }
        return(stripe_api_key)
    }
    if (in_ci()) {
        pat <- paste0("sk_test_BQokikJOvBiI2HlWgH4olfQ2")
        if (!quiet) {
            message("Using bundled STRIPE_API_KEY. Please add your own STRIPE_API_KEY to the env var `STRIPE_API_KEY`")
        }
        return(stripe_api_key)
    }
    return(NULL)
}

#' Check for presence in a CI as an environmental variable
#'
#' Looks in the environmental variable CI.  
#' Function adapted from private function in \code{package::devtools}.
#' 
#' @return \code{boolean}
in_ci <- function () 
{
    nzchar(Sys.getenv("CI"))
}