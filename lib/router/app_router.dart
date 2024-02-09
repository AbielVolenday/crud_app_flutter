import 'package:crud_app/screens/create_user/create_user.dart';
import 'package:crud_app/screens/home/home.dart';
import 'package:crud_app/screens/update_user/update_user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter AppRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: "createUser",
          path: 'createUser',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateUserScreen();
          },
        ),
        GoRoute(
            path: 'updateUser/:id',
            name: "updateUser",
            builder: (BuildContext context, GoRouterState state) {
              return UpdateUserScreen(
                id: state.pathParameters['id'],
              );
            }),
      ],
    ),
  ],
);
