# fuzzr 0.2.2

* Modifies test so as to not appear to be doing a logical test on a vector of
length > 1 
* Replaces deprecated `purrr::cross_n` and `purrr::at_depth` with
`purrr::cross` and `purrr::modify_depth`

# fuzzr 0.2.1

* Removes one call to `purrr::map_df` to be compatible with purrr 0.2.2.1.

# fuzzr 0.2

* Added a `NEWS.md` file to track changes to the package.
* Multiple test combinations with `p_fuzz_function` no longer require setting a
character delimiter. These are now properly stored within the `fuzz_results`
object. This change means that tidyr is no longer a dependency.
* Single and multiple `NA` vectors have been added to several tests.
* `test_null()` passes `NULL` as an argument value.
* `fuzz_value` and `fuzz_call` will now retrieve results by matching test names
in addition to exact index.
