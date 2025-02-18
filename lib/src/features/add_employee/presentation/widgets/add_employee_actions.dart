import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/size_constants.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/extensions/gesture_extensions.dart';
import '../../../../core/shared/text_widgets.dart';
import '../../../../core/widgets/divider/horizontal_divider.dart';

/// AddEmployeeActions - Display Actions like cancel and save
class AddEmployeeActions extends StatelessWidget {
  const AddEmployeeActions({
    super.key,
    required this.onTap,
    required this.id,
  });

  final VoidCallback onTap;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HorizontalDivider(),
        vSpace(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _actionButton(
              context,
              text: StringConstants.cancel,
              backgroundColor: ColorConstants.primary.withValues(alpha: 0.2),
              textColor: ColorConstants.primary,
              onTap: () {
                FocusScope.of(context).unfocus();
                context.pop();
              },
            ),
            hSpace(),
            _actionButton(
              context,
              text: id.isEmpty ? StringConstants.save : StringConstants.update,
              backgroundColor: ColorConstants.primary,
              textColor: ColorConstants.white,
              onTap: () {
                FocusScope.of(context).unfocus();
                onTap();
              },
            ),
          ],
        ),
        vSpace(8),
      ],
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 40,
      width: 73,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextWidgets(
        text: text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).onPressedWithHaptic(onTap);
  }
}
