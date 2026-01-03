import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage() {
    final userText = _controller.text.trim();
    if (userText.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": userText});
    });

    _controller.clear();

    final botReply = _getStaticReply(userText);

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _messages.add({"role": "bot", "text": botReply});
      });
    });
  }

  String _getStaticReply(String message) {
    final msg = message.toLowerCase();

    if (msg.contains("who am i")) {
      return "You are safe and cared for. Everything is okay.";
    } else if (msg.contains("where am i")) {
      return "You are in a familiar place. You are not alone.";
    } else if (msg.contains("scared") || msg.contains("afraid")) {
      return "It’s okay to feel scared. Take a deep breath. Help is nearby.";
    } else if (msg.contains("lost")) {
      return "Please stay calm. Your caregiver has been informed.";
    } else if (msg.contains("call") || msg.contains("daughter") || msg.contains("son")) {
      return "I will notify your caregiver right away.";
    } else if (msg.contains("help")) {
      return "I am here to help you. You are safe.";
    } else {
      return "It’s okay. I am here with you. Please tell me how you feel.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Care Assistant"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg["role"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg["text"]!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type or speak your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
