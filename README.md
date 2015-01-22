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
* `quick_edit` opens `_USERHOME/init.lua` file to edit.

#### Borrowed Algorithms.
* `comments.lua` continues comments structure from both single-line and block
comments.
* `folding` folds chunks of code by highlight or block.
* `findall` matches with all the occurance of the word under cursor.
* `multiedit` highlights all matches from `findall` with an extra cursor.

### KeyBindings

    Keys        Modules/Methods called

    cK          delete_line() and textadept.snippets._cancel_current()
    cT          open_terminal
    cae         quick_edit
    cG          multiedit.select_all()
    aright      folding.expand_fold for block/highlight
    aleft       folding.collapse_fold for block/highlight
    caright     folding.expand_folds for all blocks/highlights
    caleft      folding.collapse_folds for all blocks/highlights
    cesc        _G.reset resets Textadept.
