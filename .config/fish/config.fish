# on shell start
function fish_greeting
    echo ""
    # pfetch to know what's running rn
    pfetch

    # random fortune because fuck it
    fortune | cowsay -f tux | lolcat

    # print todo list
    cat todo
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/chud/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# !!, $, and !$ bindings
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

