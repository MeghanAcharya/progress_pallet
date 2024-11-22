import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:progresspallet/feature/dashboard/view/dashboard_screen.dart';
import 'package:progresspallet/feature/task/view/add_task_view.dart';
import 'package:progresspallet/feature/task/view/task_listing_screen.dart';
import 'package:progresspallet/feature/task_detail/view/task_detail_ui.dart';
import 'package:progresspallet/routing/navigation_service.dart';
import 'package:progresspallet/routing/routes_constants.dart';

GoRouter? globalGoRouter;

bool needToUpdateFirebase = false;
GoRouter getGoRouter() {
  return globalGoRouter ??= getRoutes();
}

Future<void> clearStackAndNavigate(BuildContext context, String path) async {
  // Set conditionally if necessary
  if (path == Routes.getRoutes(Routes.dashboard)) {
    needToUpdateFirebase = true; // Set this flag if needed for Firebase updates
  }

  // Clear the navigation stack entirely
  while (getGoRouter().canPop()) {
    getGoRouter().pop();
  }

  // Use pushReplacement to navigate to the default or specified page
  getGoRouter().pushReplacement(path);
}

String getPath(String pathName) {
  return '/$pathName';
}

Widget getInitialScreen() {
  Widget initialScreen = const DashboardScreen();

  return initialScreen;
}

GoRouter getRoutes() {
  return GoRouter(
    initialLocation: Routes.initial,
    debugLogDiagnostics: true,
    navigatorKey: NavigationService.navigatorKey,
    routes: [
      GoRoute(
        path: Routes.initial,
        name: "home",
        pageBuilder: (context, state) =>
            MaterialPage<void>(key: state.pageKey, child: getInitialScreen()),
        routes: <RouteBase>[
          GoRoute(
            path: Routes.dashboard,
            name: Routes.dashboard,
            builder: (BuildContext context, GoRouterState state) {
              return const DashboardScreen();
            },
          ),
          GoRoute(
            path: Routes.task,
            name: Routes.task,
            builder: (BuildContext context, GoRouterState state) {
              Map<String, dynamic> args = state.extra as Map<String, dynamic>;
              return TaskListScreen(
                projectId: args["id"] ?? "",
              );
            },
          ),
          GoRoute(
            path: Routes.taskDetail,
            name: Routes.taskDetail,
            builder: (BuildContext context, GoRouterState state) {
              Map<String, dynamic> args = state.extra as Map<String, dynamic>;
              return TaskDetailScreen(
                taskId: args["id"] ?? "",
              );
            },
          ),
          GoRoute(
            path: Routes.addTask,
            name: Routes.addTask,
            builder: (BuildContext context, GoRouterState state) {
              return const AddTaskView();
            },
          ),
        ],
      ),
    ],
  );
}
