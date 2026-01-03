import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isBotTyping = false;

  void _sendMessage() {
    final userText = _controller.text.trim();
    if (userText.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": userText});
      _isBotTyping = true;
    });

    _controller.clear();

    final botReply = _getStaticReply(userText);

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _messages.add({"role": "bot", "text": botReply});
        _isBotTyping = false;
      });
      _scrollToBottom();
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
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
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const CircleAvatar(child: Icon(Icons.health_and_safety, size: 20)),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Care Assistant", style: TextStyle(fontSize: 18)),
            Text("Here to help", style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color)),
          ]),
        ]),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                reverse: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _messages.length + (_isBotTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isBotTyping && index == 0) {
                    return const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: SizedBox(
                          width: 80,
                          child: LinearProgressIndicator(minHeight: 8),
                        ),
                      ),
                    );
                  }

                  final actualIndex = _isBotTyping ? index - 1 : index;
                  final msgIndex = _messages.length - 1 - actualIndex;
                  final msg = _messages[msgIndex];
                  final isUser = msg["role"] == "user";

                  return ChatBubble(text: msg["text"]!, isUser: isUser);
                },
              ),
            ),
            ChatInputBar(
              controller: _controller,
              onSend: _sendMessage,
              onMic: () {
                // preserve feature set: not implementing voice recognition now
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Voice input not implemented yet')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
