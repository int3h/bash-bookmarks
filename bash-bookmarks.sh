#!/usr/bin/env bash
# Commands to bookmark and recall directories, as in for `cd`


# The file to save bookmarks to (default to ~/.bookmarks)
if [ ! -f ${BOOKMARK_FILE:=~/.bookmarks} ]; then
    (printf "%s\n\n%s\n" '#!/usr/bin/env bash' "#User-defined directory bookmarks.\n# Create with \'bookmark name\', view with \'showboomkarks\', delete with \'rnbookmark name\'") > "$BOOKMARK_FILE"
fi


# `showbookmarks`: Display a list of bookmarks and their corresponding targets
alias showbookmarks="cat $BOOKMARK_FILE | grep -v '^#'"


# `bookmark name`: Create a bookmark 'name' pointing to the current directory
bookmark (){
    BNAME="`echo $1 | tr -d ' '`"
    # Check to be sure it's a valid bookmark name
    if [[ ! "$BNAME" =~ [a-zA-Z_]+[a-zA-Z0-9_]* ]]; then
        echo "Error: bookmark name '$BNAME' is not valid"
        return 1
    fi
    # Check if the bookmark already exists
    if [ -n "${!BNAME}" ]; then
        # Make sure the variable is coming from our bookmarks. Otherwise, it's a sys var and we
        # shoudn't shadow it with a bookmark
        if [[ "`grep ^\"$BNAME=\" \"$BOOKMARK_FILE\"`" == '' ]]; then
            echo "Error: bookmark name, '$BNAME' is the same as a shell variable. Please choose a different name"
            return 1
        fi
        read -p "This bookmark will overwrite an existing bookmark point to ${!BNAME}. Do you wish to proceed? (y/n) " OVERWRITE
        if [[ "$OVERWRITE" =~ ^[Yy] ]]; then
            rmbookmark "$BNAME"
        else
            return 1
        fi
    fi
    # add the new bookmark to the file
	echo "$BNAME=`pwd`" >> "$BOOKMARK_FILE"; 
    # strip out any empty bookmark entries
    sed -e 's/[a-zA-Z_][a-zA-Z0-9_]*=$//' -e '/^$/ d' -i '' "$BOOKMARK_FILE"
    # source the file
    source "$BOOKMARK_FILE" 
    echo "Created bookmark $BNAME to `pwd`"
}


# `removebookmark name`: remove the bookmark with name
rmbookmark (){
    sed -e "s/$1=.*\$//" -e '/^$/ d' -i '' "$BOOKMARK_FILE"
    unset $1
}

source "$BOOKMARK_FILE"  # Initialization for the above 'save' facility: source the .sdirs file
shopt -s cdable_vars # set the bash option so that no '$' is required when using the above facility
