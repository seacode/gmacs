reload <- function()
{
    .LIB    = "../R"
    .RFILES = list.files(.LIB, pattern = "\\.[Rr]$")
    for (nm in .RFILES) source(file.path(.LIB, nm), echo = FALSE)
}
