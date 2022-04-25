

#' Observe Data Tables in chosen WRDS folder
#'
#' @description Before being able to open the connection, you need to follow the steps
#'  [here](https://wrds-www.wharton.upenn.edu/pages/support/programming-wrds/programming-r/r-from-your-computer/) to set up your `.pgpass` file.
#' Usually this function is used after `wrds_inspect()` to check what data tables are included in a WRDS product.
#' For instance if you want to know the tables under tfn for the Thomson Reuters data.
#'
#' @param folder folder in WRDS that you want to inspect, find it with `wrds_inspect()`.
#' @param wrds connection created with the `wrds_connect()` function.
#'
#' @return a data.frame containing the WRDS database tables structure
#'
#' @import DBI dplyr
#'
#' @export
#'
#'
wrds_tables <- function(folder, wrds) {


  # query data

  query <- paste("select distinct table_name
            from information_schema.columns
            where table_schema='", folder,"' order by table_name", sep='')


  res <- dbSendQuery(wrds, query)

  # save data.frame
  data <- dbFetch(res, n = -1 )

  dbClearResult(res)  #not sure I need this

  return(data)

}





