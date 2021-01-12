source $ZDOTDIR/exports.zsh
source $ZDOTDIR/path.zsh
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/functions.zsh 
source $ZDOTDIR/extra.zsh

if [[ "$(ls -A $ZDOTDIR/aliases.d)" ]]; then
	for file in $ZDOTDIR/aliases.d/*.zsh
	do
		source $file 
	done
fi

