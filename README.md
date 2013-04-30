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

Save bash-bookmarks.sh somewhere on your system and add the following line to your ~/.bash_profile:

    [[ -s ~/bash-bookmarks.sh ]] && . ~/bash-bookmarks.sh

Change the path to bash-bookmarks.sh to reflect its location on your system. Close and re-open Bash and the bookmark commands should be available.

## Usage

* `bookmark name`: Create a new bookmark named *name*, pointing to the current directory.
* `showbookmarks`: List all bookmarks.
* `rmbookmark name`: Delete the bookmark named *name*.

## Configuration

By default, bookmarks are stored in ~/.bookmarks. You can change this by setting the `$BOOKMARK_FILE` shell variable before bash-bookmarks.sh is first sourced, e.g. by adding the line `BOOKMARK_FILE=~/Documents/bash-bookmarks` to ~/.bash_profile before the `[[ -s ~/bash-bookmarks.sh ]] && . ~/bash-bookmarks.sh` line.

Note that bookmarks aren't automatically transfered to any new file you specify, so if you want to keep existing bookmarks, you'll need to copy the old bookmark file to the new file.

Note also that if you change this value, is is *highly reccomended* to close and re-open your prompt. Otherwise, bookmarks from the old file will still be visible, yet all add/list/delete operations will happen over the new bookmark file.

## Caveats

All bookmark names must obey Bash variable naming rules: they must be one word, start with a letter or underscore, and contain only letters, numbers and underscores.

You can only bookmark your current working directory. If there is demand, support may be added for bookmarking arbitrary directories.

## Credit

There are a number of similar utilities floating around the net. This one was inspired by a page I've since lost, and adapated heavily for my use. If you recognize the base script, drop me a line so that I may credit it properly.
