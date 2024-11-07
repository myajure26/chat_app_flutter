import 'package:flutter/material.dart';


// * Debemos asegurarnos de que el TextEditingController y el FocusNode sean persistentes durante el ciclo de vida del widget. Para hacerlo, hay que convertir el MessageFieldBox en un StatefulWidget, de esta manera no se pierde el foco.
class MessageFieldBox extends StatefulWidget {
  final ValueChanged<String> onValue;
  const MessageFieldBox({super.key, required this.onValue});

  @override
  MessageFieldBoxState createState() => MessageFieldBoxState();
}

class MessageFieldBoxState extends State<MessageFieldBox> {
  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    final inputDecoration = InputDecoration(
      hintText: 'End your message with a "?"',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: () {
          final textValue = textController.text;
          textController.clear();
          widget.onValue(textValue);
        },
      ),
    );

    return TextFormField(
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        widget.onValue(value);
        textController.clear();
        focusNode.requestFocus();
      },
      onTapOutside: (_) {
        focusNode.unfocus();
      },
    );
  }
}