import 'package:flutter/material.dart';

class OTPInput extends StatefulWidget {
  final int length;
  final void Function(String) onCompleted;

  const OTPInput({super.key, this.length = 6, required this.onCompleted});

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int i, String value) {
    if (value.length == 1 && i < widget.length - 1) {
      _focusNodes[i + 1].requestFocus();
    }
    if (value.isEmpty && i > 0) {
      _focusNodes[i - 1].requestFocus();
    }
    final code = _controllers.map((c) => c.text).join();
    if (code.length == widget.length) {
      widget.onCompleted(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        return Container(
          width: 40,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: TextField(
            controller: _controllers[i],
            focusNode: _focusNodes[i],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(fontSize: 24),
            decoration: const InputDecoration(counterText: ''),
            onChanged: (v) => _onChanged(i, v),
          ),
        );
      }),
    );
  }
} 