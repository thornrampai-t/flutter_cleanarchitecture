import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showSnakBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(content)));
}
