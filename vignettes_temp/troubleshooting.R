## ----collapse = TRUE----------------------------------------------------------
na_logical = NA
class(na_logical)
na_py <- reticulate::r_to_py(na_logical)
na_py
na_r <- reticulate::py_to_r(na_py)
na_r

## ----collapse = TRUE----------------------------------------------------------
na_logical = c(T, F, NA)
class(na_logical)
na_py <- reticulate::r_to_py(na_logical)
na_py
na_r <- reticulate::py_to_r(na_py)
na_r

## ----collapse = TRUE----------------------------------------------------------
na_char = c("T", "F", NA)
class(na_char)
na_py <- reticulate::r_to_py(na_char)
na_py
na_r <- reticulate::py_to_r(na_py)
na_r

## ----collapse = TRUE----------------------------------------------------------
na_num = c(1538006762583, 1538006762584, NA)
class(na_num)
na_py <- reticulate::r_to_py(na_num)
na_py
na_r <- reticulate::py_to_r(na_py)
na_r

