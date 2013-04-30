bash-bookmarks
==============

A simple utility that allows you to easily save your current working diretory by assigning it a named bookmark. You can then easily `cd mybookmark`, or use your bookmark as a Bash variable.

#### Example

    mtorok (Desktop)$ cd test_1/
    mtorok (test_1)$ bookmark tests
    Created bookmark tests to /Users/mtorok/Desktop/test_1
    mtorok (Desktop)$ cd tests
    /Users/mtorok/Desktop/test_1
    mtorok (test_1)$ cd ..
    mtorok (Desktop)$ showbookmarks 
    tests=/Users/mtorok/Desktop/test_1
    mtorok (Desktop)$ rm -rf $tests
    mtorok (Desktop)$ rmbookmark tests
    mtorok (Desktop)$ 

## Installation

Put the bash-bookmarks.sh script somewhere on your system and add the following line to your ~/.bash_profile:

    [[ -s ~/bash-bookmarks.sh ]] && . ~/bash-bookmarks.sh

Change the path to the bash-bookmarks.sh script to reflect where you put it on your system. Clsoe and re-open your prompt and the bookmark commands should be available.

## Usage

* `bookmark name`: Create a new bookmark with the name *name* pointing to the current directory.
* `showbookmarks`: Display a list of current bookmarks.
* `rmbookmark name`: Deletes the bookmark with the name *name*.

## Configuration

By default, bookmarks are stored in ~/.bookmarks. You can change this setting the `$BOOKMARK_FILE` before bash-bookmarks.sh is first sourced, e.g. by adding the line `BOOKMARK_FILE=~/Documents/bash-bookmarks` to ~/.bash_profile before the above line.

Note that bookmarks aren't automatically transfered to any new file you specify, so if you want to keep existing bookmarks, you'll need to copy the old bookmark file to the new file.

Note that if you change this value, is is *highly reccomended* to close and re-open your prompt. Otherwise, bookmarks from the old file will still be visible, yet all add/list/delete operations will happen over the new bookmark file.

## Caveats

All bookmark names must obey Bash variable naming rules: they must be one word, start with a letter or underscore, and contain only letters, numbers and underscores.

If you delete the directory rerferenced by a bookmark, that bookmark will continue to exist, but will obviously produce and error if you try to `cd` to it. You can delete the bookmark itself with `rmbookmark`.

You can only bookmark your current working directory. If there is demand, support may be added for bookmarking arbitrary directories.
