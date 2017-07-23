### history ###
# share history with other terminal
setopt share_history

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# invalidate lock-unlock function
setopt no_flow_control

### prompt ###
# PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color}(%*%) %~
PROMPT="[%F{cyan}%n%f%F{red}@%m%f%F{magenta}:%~%f]%F{white}[%D/%*]"

# load files for zsh settings
ZSHHOME=$ZDOTDIR
if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi

PROMPT+="
%F{white}%% "
