import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/size_constants.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/extensions/gesture_extensions.dart';
import '../../../../core/shared/text_widgets.dart';
import '../../../../core/widgets/divider/horizontal_divider.dart';

/// AddEmployeeBottomSheetView - Display Bottom sheet role selection iew
class AddEmployeeBottomSheetView extends StatelessWidget {
  const AddEmployeeBottomSheetView({
    super.key,
    required this.onTap,
  });

  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: 16,
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      shrinkWrap: true,
      itemCount: appState.roles.length,
      separatorBuilder: (c, i) {
        return Column(
          children: [
            vSpace(),
            const HorizontalDivider(),
            vSpace(),
          ],
        );
      },
      itemBuilder: (c, i) {
        return Center(
          child: TextWidgets(
            text: appState.roles[i],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ).onPressedWithHaptic(() {
          onTap.call(appState.roles[i]);
          context.pop();
        });
      },
    );
  }
}
