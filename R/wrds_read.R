
#' Take variables from table in WRDS
#'
#' @description Before being able to open the connection, you need to follow the steps
#'  [here](https://wrds-www.wharton.upenn.edu/pages/support/programming-wrds/programming-r/r-from-your-computer/) to set up your `.pgpass` file.
#'
#' @param query string including the SQL query syntax for WRDS (see their webpage)
#' @param wrds connection created with the `wrds_connect()` function.
#' @param numrows number of observations you want to get, default is all the available ones.
#' @param data.table set to FALSE if you want a normal data.frame.
#'
#' @return a data.table or .frame containing the WRDS data requested
#'
#' @examples data <- wrds_read( "select mgrname from tfn.s34 where fdate between '2013-01-02' and '2015-03-02' ", numrows=100)
#'
#' @import DBI data.table
#' @export
#'
wrds_read <- function(query,wrds, numrows = -1, data.table = TRUE) {

  # query data
  res <- dbSendQuery(wrds, query)

  # save as data.table or as normal data.frame
  if (data.table){
    data <- setDT(dbFetch(res, n= numrows ))
  } else {
    data <- dbFetch(res, n= numrows )
  }

  dbClearResult(res)  #not sure I need this

  return(data)

}



