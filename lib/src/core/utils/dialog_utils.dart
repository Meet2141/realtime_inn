import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/size_constants.dart';
import '../constants/string_constants.dart';

/// DialogUtils - Display Alert Dialog
class DialogUtils {
  /// Displays an Alert Dialog with default Ok and Cancel action button.
  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    String? okButtonTitle,
    String? cancelButtonTitle,
    VoidCallback? cancelButtonAction,
    VoidCallback? okButtonAction,
    bool isBarrierDismissible = true,
  }) async {
    await showDialog(
      barrierDismissible: isBarrierDismissible,
      context: context,
      builder: (_) {
        return _buildDialog(
          context: context,
          title: title,
          message: message,
          content: content,
          okButtonTitle: okButtonTitle,
          cancelButtonTitle: cancelButtonTitle,
          okButtonAction: okButtonAction,
          cancelButtonAction: cancelButtonAction,
        );
      },
    );
  }

  /// Builds a Alert Dialog
  static AlertDialog _buildDialog({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    String? okButtonTitle,
    String? cancelButtonTitle,
    VoidCallback? okButtonAction,
    VoidCallback? cancelButtonAction,
  }) {
    return AlertDialog.adaptive(
      title: Text(title),
      content: content ?? Text(message ?? ''),
      actions: _buildActions(
        context: context,
        okButtonTitle: okButtonTitle,
        cancelButtonTitle: cancelButtonTitle,
        okButtonAction: okButtonAction,
        cancelButtonAction: cancelButtonAction,
      ),
    );
  }

  /// Builds dialog actions
  static List<Widget> _buildActions({
    required BuildContext context,
    String? okButtonTitle,
    String? cancelButtonTitle,
    VoidCallback? okButtonAction,
    VoidCallback? cancelButtonAction,
  }) {
    final List<Widget> actions = [];

    actions.add(
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          cancelButtonAction?.call();
        },
        child: Text(
          cancelButtonTitle ?? StringConstants.cancel,
          style: const TextStyle(
            fontSize: SizeConstants.large,
            color: ColorConstants.red,
          ),
        ),
      ),
    );

    actions.add(
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          okButtonAction?.call();
        },
        child: Text(
          okButtonTitle ?? StringConstants.ok,
          style: const TextStyle(
            fontSize: SizeConstants.large,
          ),
        ),
      ),
    );

    return actions;
  }
}
