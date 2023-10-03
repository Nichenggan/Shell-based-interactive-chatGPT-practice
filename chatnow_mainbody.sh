path="/mnt/d/github/chatnow" #enter your path here
chatnow(){
    echo "Welcome to Chatnow, type \"start\" to start, type \"exit\" to quit, type \"help\" for more commands." 
    module=1
    while true; do
        read -p ">>>" command
        if [ "$command" = "exit" ]; then
            echo Good bye!
            break
        elif [ "$command" = "start" ]; then
            $path/chatloop.sh $module
        elif [ "$command" = "help" ]; then
            cat $path/help_chatnow.txt
        elif [ "$command" = "core" ]; then
            if [ $module = 1 ]; then
                echo "We are using the gpt-3.5-turbo model. It's stable and quick."
            else
                echo "We are using the gpt-3.5-turbo-16k model. It can receive far more tokens."
            fi
        elif [ "$command" = "core -default" ]; then
            echo "Change the core to gpt-3.5-turbo model."
            module=1
        elif [ "$command" = "core -creative" ]; then
            echo "Change the core to gpt-3.5-turbo-16k model."
            module=2
        fi
    done
}

chatnow