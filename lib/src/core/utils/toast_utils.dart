import 'package:bot_toast/bot_toast.dart';
import '../constants/color_constants.dart';
import '../constants/image_constants.dart';
import '../extensions/gesture_extensions.dart';
import '../shared/image_viewer.dart';
import '../shared/text_widgets.dart';
import 'enums.dart';
import 'package:flutter/material.dart';

/// ToastUtils class is used for toast in app.
class ToastUtils {
  static late Function() cancel;

  static void cancelToast() {
    cancel();
  }

  /// Show success toast
  static void showSuccess({required String message}) {
    cancel = BotToast.showCustomNotification(
      duration: const Duration(seconds: 2),
      toastBuilder: (cancelFunc) {
        return toastView(
          message: message,
          image: ImageConstants.icCheck,
          cardColor: ColorConstants.toastSuccess,
        );
      },
    );
  }

  /// Show Failed toast
  static void showFailed({required String message}) {
    cancel = BotToast.showCustomNotification(
      duration: const Duration(seconds: 2),
      toastBuilder: (cancelFunc) {
        return toastView(
          message: message,
          image: ImageConstants.icError,
          cardColor: ColorConstants.toastFailure,
        );
      },
    );
  }

  ///toastView - Display Toast View
  static Widget toastView({
    required String message,
    required String image,
    required Color cardColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        elevation: 5,
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageViewer(
                imageData: ImageData(
                  type: ImageType.svg,
                  src: image,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextWidgets(
                  text: message,
                  style: const TextStyle(fontSize: 12, color: ColorConstants.black),
                  maxLine: 5,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              ImageViewer(
                imageData: ImageData(
                  type: ImageType.svg,
                  src: ImageConstants.icCancel,
                ),
                height: 16,
                width: 16,
                color: ColorConstants.primary,
              ).onPressedWithoutHaptic(cancelToast),
            ],
          ),
        ),
      ),
    );
  }
}
