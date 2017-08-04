# ta-common
A collection of algorithms made or found by [Alejandro Baez](https://twitter.com/a_baez).

---

### DESCRIPTION
As the subtitle said.This is a simple collection of algorithms made by others
and algorithms I made myself for the use of making [Textadept](http://foicica.com/textadept)
more useful.

### MODULES
#### Self Constructed
* `init`  holds the call to all modules and keybindings for ones in use.
* `delete_line` deletes the current line or the highlighted lines.
* `open_terminal` opens a terminal at the current directory of
`buffer.filename()`.
* `themer` changes to a different them from [base16-builder](https://github.com/chriskempson/base16-builder)
in your themes directory, for every run.
* `quick_edit` opens `_USERHOME/init.lua` file to edit.
* `nav` a very simple *hjkl* navigation.

#### Borrowed Algorithms
* `comments.lua` continues comments structure from both single-line and block
comments.
* `folding` folds chunks of code by highlight or block.
* `findall` matches with all the occurance of the word under cursor.
* `multiedit` highlights all matches from `findall` with an extra cursor.
* `elastic_tabstops` [elastic tabstops](http://nickgravgaard.com/elastic-tabstops/)
implementation for textadept.

### USAGE
To enable, you need to add the following to your `_USERHOME/init.lua`:

```
require("common")
```

Much of the modules are self initializing. However, some do need to be enabled
in `_USERHOME/init.lua`.

* `themer`: The default randomly picks from themes in `_USERHOME/themes`. It
chooses `-light` themes when the hour of the day is between `06` and `17`.
It also uses `Inconsolata` as the font and `14` as the fontsize. YOu can change
all this by adding the following to your `_USERHOME/init.lua` before common is
loaded:

```
-- font to choose.
CURRENT_FONT = "Fantasque Sans Mono"
-- fontsize to choose.
CURRENT_FONTSIZE = 13
-- chose a specific theme.
CURRENT_THEME = "base16-atelierlakeside-light"
-- need to enable for specific theme to be work.
CURRENT_BACKGROUND = "-light"
-- initial time to start `-light` background theme.
TIME_INITIAL = 09
-- initial time to start `-light` background theme.
TIME_FINAL = 13
```
* `elastic_tabstops` to enable, you simply need to add the following boolean to
your `_USERHOME/init.lua`:

```
-- enable elastic_tabstops
TABSTOP_ENABLE = true
```

* `nav` is enabled by default. To disble simple add this to your
`_USERHOME/init.lua`:

```
-- disable nav
NAV_DISABLE = true
```

#### Keybindings

    Keys        Modules/Methods called

    cK          delete_line() and textadept.snippets._cancel_current()
    cT          open_terminal
    cae         quick_edit
    aW          multiedit.select_all()
    aw          multiedit.select_word()
    aright      folding.expand_fold for block/highlight
    aleft       folding.collapse_fold for block/highlight
    caright     folding.expand_folds for all blocks/highlights
    caleft      folding.collapse_folds for all blocks/highlights
    cesc        _G.reset resets Textadept.

### LICENSE
All modules/methods under [Borrowed Algorithms](#Borrowed.Algorithms) are under
license in modules.
All modules/methods under [Self Constructed](#Self.Constructed) are under the
following license:

The MIT License (MIT)

Copyright (c) 2014-2016 [Alejandro Baez](https://twitter.com/a_baez)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

