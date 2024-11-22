class Routes {
  static const initial = '/';

  static const dashboard = "dashboard";
  static const task = "task";
  static const taskDetail = "taskDetail";
  static const addTask = "addTask";
  static String getRoutes(String routeName) => '/$routeName';
}
