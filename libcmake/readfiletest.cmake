site_name(sitename)
message("sitename=${sitename}")
return()

file(READ libcmake/readfiletest.cmake contents)
message("contents=${contents}")
file(READ libcmake/readfiletest.cmake hexcontents HEX)
message("hexcontents=${hexcontents}")
