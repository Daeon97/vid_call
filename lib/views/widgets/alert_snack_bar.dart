// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

final class AlertSnackBar {
  static void show(
    BuildContext context, {
    required String message,
  }) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              message,
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
}
