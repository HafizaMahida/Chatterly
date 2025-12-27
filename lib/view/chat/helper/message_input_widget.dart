import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/widgets/common_form_field.dart';
import 'package:chat_app/view_model/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageInput extends ConsumerWidget {
  final String userId;
  const MessageInput({super.key,required this.userId});

  @override
  Widget build(context,ref){
    final chatRead = ref.read(chatController);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: CommonFormField(
                controller: chatRead.chatCtr,
                borderRadius: 20,
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: AppColors.brandYellow,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  chatRead.sendMessage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}