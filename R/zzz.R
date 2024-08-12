.onAttach <- function(libname, pkgname) {
  # Welcome message
  packageStartupMessage(
    "This is BubbleTime version ", utils::packageVersion("BubbleTime"), "."
  )
}
