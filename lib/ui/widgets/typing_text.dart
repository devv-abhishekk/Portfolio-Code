import 'dart:async';
import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const TypingText({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  String _currentText = "";
  int _index = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_index < widget.text.length) {
        if (mounted) {
          setState(() {
            _currentText += widget.text[_index];
            _index++;
          });
        }
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentText,
      style: widget.style,
    );
  }
}
