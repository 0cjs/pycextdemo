site_name(sitename)
message("sitename=${sitename}")
return()

file(READ cmake/readfiletest.cmake contents)
message("contents=${contents}")
file(READ cmake/readfiletest.cmake hexcontents HEX)
message("hexcontents=${hexcontents}")
