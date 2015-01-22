# ta-common
A collection of algorithms made or found by [Alejandro Baez](https://twitter.com/a_baez).

---

### DESCRIPTION
As the subtitle said.This is a simple collection of algorithms made by others
and algorithms I made myself for the use of making [Textadept](http://foicica.com/textadep)
more useful.

### MODULES
#### Self Constructed.
* `init`  holds the call to all modules and keybindings for ones in use.
* `delete_line` deletes the current line or the highlighted lines.
* `open_terminal` opens a terminal at the current directory of
`buffer.filename()`.
* `themer` changes to a different them from [base16-builder](https://github.com/chriskempson/base16-builder)
in your themes directory, for every run.

#### Borrowed Algorithms.
* `comments.lua` continues comments structure from both single-line and block
comments.
* `findall` matches with all the occurance of the word under cursor.
* `multiedit` highlights all matches from `findall` with an extra cursor.
