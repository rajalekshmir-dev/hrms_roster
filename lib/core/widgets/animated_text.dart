import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedTypingHint extends StatefulWidget {
  final String text;

  const AnimatedTypingHint({super.key, required this.text});

  @override
  State<AnimatedTypingHint> createState() => _AnimatedTypingHintState();
}

class _AnimatedTypingHintState extends State<AnimatedTypingHint> {
  String displayedText = "";
  int index = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (index < widget.text.length) {
        setState(() {
          displayedText += widget.text[index];
          index++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayedText,
      style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
    );
  }
}
