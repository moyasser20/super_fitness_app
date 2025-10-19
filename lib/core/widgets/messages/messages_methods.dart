import 'package:flutter/material.dart';
import 'custom_message_widget.dart';
import 'message_type.dart';

void showSuccessMessage(BuildContext context, String message) {
  final overlay = Overlay.of(context);

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder:
        (context) => CustomMessageWidget(
          message: message,
          type: MessageType.success,
          entry: entry,
        ),
  );

  overlay.insert(entry);
}

void showErrorMessage(BuildContext context, String message) {
  final overlay = Overlay.of(context);

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder:
        (context) => CustomMessageWidget(
          message: message,
          type: MessageType.error,
          entry: entry,
        ),
  );

  overlay.insert(entry);
}
