#' Convert an object to an \code{\link{rtable}} object
#' 
#' Generic for converting objects to an \code{\link{rtable}} object
#' 
#' @inheritParams dim.rtable
#' @param format format of the cells
#' 
#' @export
as.rtable <- function(x, format = "xx") {
  UseMethod("as.rtable")
}

#' @export
as.rtable.default <- function(x, format) {
  stop("no default implementation for as.rtable")
}


#' Convert a table object to an \code{\link{rtable}}
#' 
#' @inheritParams as.rtable
#' 
#' @importFrom stats setNames
#' @export
#' 
#' @examples 
#' 
#' tbl <- as.rtable(table(iris$Species))
#' tbl
#' 
#' \dontrun{
#' Viewer(tbl)
#' }
#' 
#' 
#' tbl <- as.rtable(table(sample(letters[1:4], 200, TRUE), sample(LETTERS[1:4], 200, TRUE)))
#' tbl
#' \dontrun{
#' Viewer(tbl, row.names.bold = TRUE)
#' }
#' 
as.rtable.table <- function(x, format = "xx") {
  
  if (length(dim(x)) == 1) {
    rtable(
      do.call(rrow, c(list(row.name = "1"), as.list(as.vector(x)))), 
      headers = names(x), 
      format = format)
  } else {
    X <- as.data.frame.matrix(x)
    rrows <- Map(function(row, row.name) {
      do.call(rrow, as.list(c(row.name=row.name, setNames(row, NULL))))
    }, as.data.frame(t(X)), rownames(X))
    
    print(rrows)
    do.call(rtable, c(as.list(rrows), list(headers = names(X), format = format)))
  }
}
