import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageInput extends StatelessWidget {
  final Function(String) onSendMessage;

  const MessageInput({required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8),
        color: theme.cardColor.withValues(alpha: 0.05),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: theme.textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: theme.scaffoldBackgroundColor,
                ),
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.camera_alt, color: theme.iconTheme.color),
              onPressed: () async{
                final ImagePicker picker = ImagePicker();
                final XFile? photo = await picker.pickImage(source: ImageSource.camera);
              },
            ),
            IconButton(
              icon: Icon(Icons.send, color: theme.iconTheme.color),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  onSendMessage(_controller.text);
                  _controller.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
