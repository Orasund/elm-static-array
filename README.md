# elm-static-array

Arrays with fixed length!

**Pros**

* Length is checked in compile time by using phantom types.
* Single Constructor Types ensure that no performance is lost.
* Convert Custom Types into Int and back without needing a dead branch in the case distinction.

**Cons**

* Construction of an Array needs more line of code.
* If you don't know why this package is useful, you should not be using it.