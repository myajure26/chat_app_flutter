import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/message.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/chat/his_message_bubble.dart';
import '../../widgets/chat/my_message_bubble.dart';
import '../../widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundImage: NetworkImage('https://i.pinimg.com/originals/0c/3b/3a/0c3b3adb1a7530892e55ef36d3be6cb8.png')),
        ),
        title: const Text('Mi amor 💙'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    controller: chatProvider.scrollController,
                    itemCount: chatProvider.messagesList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messagesList[index];

                      return (message.fromWho == FromWho.his) 
                      ? HisMessageBubble(message: message)
                      : MyMessageBubble(message: message.text);
                    })),

            /// Caja de texto de mensajes
            MessageFieldBox(onValue: (value) => chatProvider.sendMessage(value),),
          ],
        ),
      ),
    );
  }
}