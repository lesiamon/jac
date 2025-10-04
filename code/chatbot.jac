with entry {
    ("Hello! I'm ShopBot 🤖. Type 'bye' to exit.");
}
while True:
    user_input = input("You: ").lower()

    if user_input == "bye":
        print("Bot: Goodbye! Have a nice day!")
        break
    elif "hello" in user_input or "hi" in user_input:
        print("Bot: Hi there! How can I help you?")
    elif "profit" in user_input:
        print("Bot: Profit is Sales minus Cost. Do you want me to calculate it?")
    elif "name" in user_input:
        print("Bot: I'm ShopBot, your friendly assistant!")
    elif "help" in user_input:
        print("Bot: I can chat with you about profit, greetings, or my name.")
    else:
        print("Bot: Sorry, I don’t understand that.")
