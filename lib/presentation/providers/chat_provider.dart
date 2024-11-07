import 'package:chat_flutter/config/helpers/get_yes_no_answer.dart';
import 'package:chat_flutter/domain/entities/message.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messagesList = [
    Message(text: 'Hola amor', fromWho: FromWho.me),
    Message(text: '¿Ya regresaste del trabajo?', fromWho: FromWho.me)
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messagesList.add(newMessage);

    if (text.endsWith('?')) {
      hisReply(text);
    }

    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> hisReply(String text) async {
    final hisMessage = await getYesNoAnswer.getAnswer();
    messagesList.add(hisMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
