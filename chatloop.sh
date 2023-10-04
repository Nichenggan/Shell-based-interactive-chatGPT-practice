path="/mnt/d/github/chatnow" #modify your path here

touch $path/messages.txt
echo 0 > $path/tokens.txt
echo "{\"role\": \"system\", \"content\": \"You are a helpful assistant.\"}" > $path/messages.txt
echo "Enjoy your chat now ! Try not to use Double quotation marks. Type -end to end the conversation. Type -tokens to see how many tokens used."

module=$1
if [ $module = 1 ]; then
    set_module=$(cat $path/config.txt | head -2 | tail -1)
else
    set_module=$(cat $path/config.txt | head -3 | tail -1)
fi

chatloop(){
    while true; do
        read -p "Your texte : " texte
        if [ "$texte" = "-end" ]; then
            rm $path/messages.txt
            rm $path/tokens.txt
            echo You have ended the conversation. The histroy is been removed.
            break
        elif [ "$texte" = "-tokens" ]; then
            echo $(cat $path/tokens.txt)
        else
            api=$(cat $path/config.txt | head -1)
            echo "{\"role\": \"user\", \"content\": \"$texte\"}" >> $path/messages.txt
            conversation=$(cat $path/messages.txt)
            response=$(python3 $path/chatgptcore.py "$api" "$conversation" "$path" "$set_module")
            echo "{\"role\": \"assistant\", \"content\": \"$response\"}" >> $path/messages.txt 
            echo $response
        fi
    done
}

chatloop