import openai
import sys

openai.api_key = sys.argv[1]

#convert the message to the style we need
message = sys.argv[2].split("\n")
new_message = []
for i in message:
    new_message.append(eval(i))

#put the model seletion here
Model = sys.argv[4]


response = openai.ChatCompletion.create(
	model=Model,
	messages=new_message,
	temperature=0,
)

with open(f"{sys.argv[3]}/tokens.txt", "w+") as file:
    token = response['usage']['total_tokens']
    file.write(f"{token}")

output = response['choices'][0]['message']['content'].replace('"', '')

print(output)




