#' Onedrive Excel
#'
#' @param sharedURL  shared link from OneDrive excel file
#' @param file_name Local file name
#' @param save2wd save the file to their working directory?
#'
#' @importFrom readxl read_excel
#' @importFrom curl curl_download
#'
#' @export
#' @examples
#' url <- "https://1drv.ms/x/s!AvKSrDD28Jp5q-MDRzpOYGOMSTtmqg?e=kMpWaa"
#' onedriver_excel(url, file_name = "example.xlsx")
#'
onedriver_excel <- function(sharedURL, file_name, save2wd = FALSE) {

  # Save the shared url
  URL1 <- unlist(strsplit(sharedURL, "[?]"))[1]
  URL1 <- paste0(URL1, "?download=1") # edit URL to make it a downloadable link

  # Download the file to a temp directory using the supplied file name
  curl::curl_download(
    URL1,
    destfile = file.path(tempdir(), file_name),
    mode = "wb"
  )


  # If the user wants it saved to thier working directory this will copy the file
  if (isTRUE(save2wd)) {
    file.copy(
      from = paste0(tempdir(), "\\", file_name),
      to = "./"
    )
  }
  # return the CSV as a data.frame
  return(readxl::read_excel(paste0(tempdir(), "\\", file_name)))
}
