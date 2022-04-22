#' Observe Tables structure in WRDS
#'
#' @description Remember to change the username in the dbConnect call below. Before being able to open the connection, you need to follow the steps
#'  [here](https://wrds-www.wharton.upenn.edu/pages/support/programming-wrds/programming-r/r-from-your-computer/) to set up your `.pgpass` file.
#'
#' @param wrds connection created with the wrds.connect() function.
#' @return a data.frame containing the WRDS database tables structure
#'
#' @import DBI dplyr
#'
#' @export
#'
#'
wrds_inspect <- function(wrds) {


  # query data

  query <- "select distinct table_schema
                   from information_schema.tables
                   where table_type ='VIEW'
                   or table_type ='FOREIGN TABLE'
                   order by table_schema"

  res <- dbSendQuery(wrds, query)

  # save data.frame
  data <- dbFetch(res, n = -1 )

  dbClearResult(res)  #not sure I need this


  return(data)

}

