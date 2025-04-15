import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlocEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hitText;
  const BlocEditor({
    super.key,
    required this.controller,
    required this.hitText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hitText),
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hitText is missing';
        }
        return null;
      },
    );
  }
}
