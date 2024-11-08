import 'dart:io';

import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];

  final textController = TextEditingController();
  final focus = FocusNode();
  bool _estaescribiendo = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ChatService>(context).userFor;
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                maxRadius: 15,
                backgroundColor: Colors.blue[100],
                child:  Text(
                  user.name.substring(0,2),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                
                user.name,
                style: const TextStyle(color: Colors.black87, fontSize: 15),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Flexible(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
            )),
            const Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              height: 100,
              child: _inputChat(),
            )
          ],
        ));
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            onSubmitted: _handleSubmit,
            onChanged: (text) {
              setState(() {
                if (text.trim().isNotEmpty) {
                  _estaescribiendo = true;
                } else {
                  _estaescribiendo = false;
                }
              });
            },
            decoration:
                const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            controller: textController,
            focusNode: focus,
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Platform.isIOS
                ? CupertinoButton(child: const Text('Enviar'), onPressed: () {})
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: _estaescribiendo
                              ? () => _handleSubmit(textController.text)
                              : null,
                          icon: const Icon(
                            Icons.send,
                          )),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    if (text.isEmpty){
      return;
    }
    focus.requestFocus();
    textController.clear();

    final newMessage = ChatMessage(
      text: text,
      uuid: '123',
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaescribiendo = false;
    });
  }

  @override
  void dispose() {
    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }
}
