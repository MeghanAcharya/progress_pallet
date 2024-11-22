class AppEndPoints {
  static String baseUrl = "https://api.todoist.com";
  static String restApi = "/rest";
  static String version = "/v2";
  static String getAllProjects = "/projects";
  static String getTasksUnderProject = "/tasks";
  static String getTaskDetail = "/tasks/";
  static String getAllComments = "/comments";
  static String postComment = "/comments";
  static String addTask = "/tasks";
  static Uri getRequestUrl(
    String path, {
    Map<String, dynamic>? queryParams,
  }) {
    Uri uri;

    uri = Uri.parse(baseUrl + restApi + version + path);

    if (queryParams != null) {
      uri = Uri(
        scheme: uri.scheme,
        host: uri.host,
        port: uri.port,
        path: uri.path,
        queryParameters: queryParams,
      );
    }

    return uri;
  }

  static String getRequestPath(String routeName) =>
      '$baseUrl$restApi$version$routeName';
}
