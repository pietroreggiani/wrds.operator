

#' Open connection to WRDS
#'
#' @description Before being able to open the connection, you need to follow the steps
#'  [here](https://wrds-www.wharton.upenn.edu/pages/support/programming-wrds/programming-r/r-from-your-computer/) to set up your `.pgpass` file.
#'  This function should be run before all other wrds. functions, to open the database connection.
#' @param username string of the username you have with WRDS.
#' @examples wrds_connect( "preggian")
#'
#' @import RPostgres
#' @export
#'
wrds_connect <- function(username) {


  # Open connection to wrds
  if (!exists('wrds')){
    wrds <- dbConnect(Postgres(),
                      host='wrds-pgdata.wharton.upenn.edu',
                      port=9737,
                      dbname='wrds',
                      sslmode='require',
                      user=username)
  } else if (class(wrds)[1]=="PqConnection"   ) {
    warning('The wrds connection is already open, you can proceed to query data.')
  } else {
    stop("There is an object named wrds that is not a database connection, please remove or rename it before running this function.")
  }

  return(wrds)

}

