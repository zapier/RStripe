# --------------------------------------------------
# Charges
# --------------------------------------------------

#' Create a charge.
#'
#' @param api_key Your Stripe API Key
#' @param args A list which must contain \strong{amount} and 
#' \strong{currency}. It also either needs \strong{customer} or \strong{card}
#' It can also contain \strong{description}, \strong{metadata},
#' \strong{capture}
#' \strong{statement_description}, \strong{receipt_email},
#' \strong{application_fee}
#' @export
#' @examples stripe_create_charge("sk_test_BQokikJOvBiI2HlWgH4olfQ2",
#' list(card="tok_14SsjM2eZvKYlo2CCtdx2AvO", amount=3000, currency="usd",
#' metadata=list(order_id="12545")))
#' @return A data frame with the new charge info if successful.
stripe_create_charge <- function(api_key,args) {
    args <- .downcase(args, FALSE)
    args <- .downcase(args, TRUE)
    args <- .card(args)
    link <- "https://api.stripe.com/v1/charges"
    .post(api_key, link, args)
}

#' Retrieve a charge.
#'
#' @param api_key Your Stripe API Key
#' @param charge_id The identifier of the charge to be retrieved
#' @export
#' @examples stripe_retrieve_charge("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' "ch_14TLyd2eZvKYlo2CdryxwrF8")
#' @return Returns a charge data frame if valid.
stripe_retrieve_charge <- function(api_key, charge_id) {
    link <- paste0("https://api.stripe.com/v1/charges/", charge_id)
    .get(api_key, link)
}

#' Update a charge.
#'
#' @param api_key Your Stripe API Key
#' @param charge_id The identifier of the charge to be updated
#' @param args A list that can include metadata and/or a description
#' @export
#' @examples stripe_update_charge("sk_test_BQokikJOvBiI2HlWgH4olfQ2", 
#' "ch_14TLyd2eZvKYlo2CdryxwrF8", list(description="for the item",
#' metadata=list(order_id="3453")))
#' @return Returns a charge data frame if succeeded.
stripe_update_charge <- function(api_key, charge_id, args) {
    if(!is.null(args["description"]) | !is.null(args["metadata"])) {
        args <- .metadata(args)
        link <- paste0("https://api.stripe.com/v1/charges/", charge_id)
        .post(api_key, link, args)
    } else {
        print("There is nothing to update!")
    }
}

#' Capture a charge.
#'
#' @param api_key Your Stripe API Key
#' @param charge_id The identifier of the charge to be captured
#' @param args an optional list that can include \strong{amount},
#' \strong{application_fee}, \strong{receipt_email}
#' @export
#' @return Returns a charge data frame if the capture succeeded.
stripe_capture_charge <- function(api_key, charge_id, args=NULL) {
    link <- paste0("https://api.stripe.com/v1/charges/",charge_id, "/capture")
    .post(api_key, link, args)
}

#' List all charges.
#'
#' @param api_key Your Stripe API Key
#' @param charge_id The identifier of the charge to be captured
#' @param args an optional list that can include \strong{customer},
#' \strong{created}, \strong{optional}, \strong{ending_before},
#' \strong{limit}, \strong{starting_after}
#' @export
#' @return Returns a data frame with all customer charges.  10 if no limit specified.
stripe_list_charges <- function(api_key, args=NULL) {
    args <- .convert_to_url(args)
    link <- paste0("https://api.stripe.com/v1/charges",args)
    .get(api_key, link)
}