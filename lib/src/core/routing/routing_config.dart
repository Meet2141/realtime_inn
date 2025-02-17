import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/add_employee/presentation/add_employee_screen.dart';
import '../../features/employee/presentation/employee_screen.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../constants/routing_constants.dart';

///RoutingConfig - Handle Routing of application
class RoutingConfig {
  static GoRouter router = GoRouter(
    initialLocation: RoutingConstants.initial,
    routes: <GoRoute>[
      GoRoute(
        path: RoutingConstants.initial,
        name: RoutingConstants.splash,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SplashBloc(),
            child: const SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: RoutingConstants.initial + RoutingConstants.employee,
        name: RoutingConstants.employee,
        builder: (context, state) {
          return const EmployeeScreen();
        },
      ),
      GoRoute(
        path: RoutingConstants.initial + RoutingConstants.addEmployee,
        name: RoutingConstants.addEmployee,
        builder: (context, state) {
          return const AddEmployeeScreen();
        },
      ),
    ],
    observers: <NavigatorObserver>[
      BotToastNavigatorObserver(),
    ],
  );
}
