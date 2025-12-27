import 'package:chat_app/view/chat/helper/search_meaning_bottom_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WordSelectableText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const WordSelectableText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');

    return RichText(
      text: TextSpan(
        children: words.map((word) {
          return TextSpan(
            text: '$word ',
            style: style ?? const TextStyle(color: Colors.black),
            recognizer: LongPressGestureRecognizer()
              ..onLongPress = () {
                final cleanWord =
                word.replaceAll(RegExp(r'[^\w]'), '');
                if (cleanWord.isNotEmpty) {
                  onWordLongPress(context, cleanWord);
                }
              },
          );
        }).toList(),
      ),
    );
  }
}

void onWordLongPress(BuildContext context, String word) async {
  showWordMeaningBottomSheet(context,word);
}

