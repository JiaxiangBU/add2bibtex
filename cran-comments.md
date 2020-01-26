## Test environments
* local OS X install, R 3.6.0
* ubuntu 14.04 (on travis-ci), R 3.6.0
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 6 note

* Change the year of the LICENSE.
* Change Description in the DESCRIPTION into normal case.
* 'add_bibtex()' just pastes the text on the user's clipboard, and then the users change the metadata in the text.
* Add the return and examples into the functions.
* Use 'message' instead 'cat' to print the function message.
* Write 'BibTex' into single quotes into Title.
