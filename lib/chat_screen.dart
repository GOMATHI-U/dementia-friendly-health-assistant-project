import 'package:flutter/material.dart';
import 'chatbot_service.dart'; // Import the chatbot logic

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController userInput = TextEditingController();
  ChatbotService chatbot = ChatbotService();
  List<String> messages = [];

  void sendMessage() async {
    String message = userInput.text;
    if (message.isEmpty) return;

    setState(() {
      messages.add("You: $message");
      userInput.clear();
    });

    String response = await chatbot.getResponse(message);

    setState(() {
      messages.add("Bot: $response");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => ListTile(title: Text(messages[index])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: userInput, decoration: InputDecoration(hintText: "Type a message..."))),
                IconButton(icon: Icon(Icons.send), onPressed: sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
