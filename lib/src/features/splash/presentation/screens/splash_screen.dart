import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routing_constants.dart';
import '../../../../core/constants/size_constants.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/extensions/scaffold_extension.dart';
import '../../../../core/shared/text_widgets.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/splash_bloc.dart';

///SplashScreen - Display Splash Screen of the application
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    ///Navigation Event called via SplashBloc
    context.read<SplashBloc>().add(SplashNavigateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashSuccess) {
          context.goNamed(RoutingConstants.employee);
        }
        if (state is SplashFailure) {
          ToastUtils.showFailed(message: StringConstants.somethingWentWrong);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top,
          bottom: MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Splash Text
            Expanded(
              child: Center(
                child: TextWidgets(
                    text: StringConstants.appName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: SizeConstants.extraLarge,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///By Text
                TextWidgets(
                  text: StringConstants.by.toUpperCase(),
                  style: const TextStyle(
                    fontSize: SizeConstants.small,
                  ),
                ),
                hSpace(12),

                ///Developer Name Text
                TextWidgets(
                  text: StringConstants.developerName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: SizeConstants.medium,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ).baseScaffoldNoAppBar();
  }
}
