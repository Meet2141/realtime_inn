import '../constants/string_constants.dart';
import 'log_utils.dart';
import 'toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// CopyToClipBoardUtils - Display Copy to Clipboard
class CopyToClipBoardUtils {
  static Future<void> copy(
    BuildContext context, {
    required String data,
  }) async {
    try {
      await Clipboard.setData(
        ClipboardData(text: data),
      );
      if (context.mounted) {
        ToastUtils.showSuccess(message: StringConstants.copiedToClipBoard);
      }
    } catch (e, st) {
      LogUtils.print('Error: $e', st: st, message: 'copy-clipboard-failed');
    }
  }
}
