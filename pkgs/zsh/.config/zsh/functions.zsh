function md {
    mkdir -p $@
    cd $@
}

function mf {
    mkdir -p $(dirname $@)
    touch $@
}

function mfe {
    mf $@
    $EDITOR $@
}

# search&edit
function se {
    if [[ $# -gt 0 ]]; then
        fd . $1 | fzf | xargs $EDITOR 
    else
        fzf | xargs $EDITOR
    fi
}
