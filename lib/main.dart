import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_chat/chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ChatMessage> _messages;
  late TextEditingController _textController;

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: _textController.text,
          time: DateTime.now(),
          author: const ChatAuthor(id: '1010', name: 'Andreson'),
        ));
        _textController.clear();
      });
    }
  }

  Widget _buildComposer() {
    bool hasText = _textController.text.isNotEmpty;

    return TextField(
      controller: _textController,
      minLines: 1,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Enter message here...',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        prefixIcon: Icon(
          Icons.mic_none_outlined,
          color: hasText ? Colors.grey.shade500 : null,
        ),
        suffixIcon: hasText
            ? Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Transform.rotate(
                    angle: 45 * (3.141592653589793 / 180),
                    child: Icon(
                      hasText
                          ? CupertinoIcons.paperplane_fill
                          : CupertinoIcons.paperplane,
                      color: hasText
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
                  onPressed: _sendMessage,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  void _handleTextChange() {
    setState(() {});
  }

  @override
  void initState() {
    _textController = TextEditingController()..addListener(_handleTextChange);
    _messages = [
      ChatMessage(
        text: 'Hi Anderson, how are you?',
        time: DateTime.now().subtract(const Duration(minutes: 100)),
        author: const ChatAuthor(id: '1011', name: 'Jackson'),
      ),
      ChatMessage(
        text: 'I\'m good, thanks. How are you?',
        time: DateTime.now().subtract(const Duration(minutes: 97)),
        author: const ChatAuthor(id: '1010', name: 'Andreson'),
      ),
      ChatMessage(
        text:
            'I\'m okay. Thinking of doing something fun this weekend. Any ideas?',
        time: DateTime.now().subtract(const Duration(minutes: 95)),
        author: const ChatAuthor(id: '1011', name: 'Jackson'),
      ),
      ChatMessage(
        text:
            'That sounds good. Maybe we could go to the park or watch a movie?',
        time: DateTime.now().subtract(const Duration(minutes: 92)),
        author: const ChatAuthor(id: '1010', name: 'Andreson'),
      ),
      ChatMessage(
        text: 'I was thinking of going on a trip.',
        time: DateTime.now().subtract(const Duration(minutes: 89)),
        author: const ChatAuthor(id: '1011', name: 'Jackson'),
      ),
      ChatMessage(
        text: 'Oh, that\'s cool! Where are you thinking of going?',
        time: DateTime.now().subtract(const Duration(minutes: 86)),
        author: const ChatAuthor(id: '1010', name: 'Andreson'),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SfChat(
          messages: _messages,
          outgoingUser: '1010',
          composer: ChatComposer.builder(
            builder: (context) {
              return _buildComposer();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messages.clear();
    _textController
      ..removeListener(_handleTextChange)
      ..dispose();
    super.dispose();
  }
}
