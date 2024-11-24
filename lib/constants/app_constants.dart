import 'package:progresspallet/constants/app_images.dart';

class AppConstants {
  //constant
  static String appName = "Task pallet";

  //Remote config keys
  static String bearerTokenKey = "bearer_token";
  static String defaultUser = "default_user";

  static int shortestSide = 600;
  static int smallerDevice = 380;

  static int maxListTextLines = 2;

  static const List<String> supportedLanguages = ['en'];
  static const String defaultLangCode = "en";

  static const List<String> bannerArray = [
    AppImages.banner1,
    AppImages.banner2,
    AppImages.banner3,
  ];

  static const String todoStatus = "2";
  static const String inProgressStatus = "4";
  static const String completedStatus = "6";

  static const Map<String, dynamic> taskStatusData = {
    "statusData": [
      {"statusCode": todoStatus, "status": "Todo", "statusKey": "todo"},
      {
        "statusCode": inProgressStatus,
        "status": "In progress",
        "statusKey": "inProgress"
      },
      {
        "statusCode": completedStatus,
        "status": "Completed",
        "statusKey": "completed"
      }
    ]
  };

  static const String mmmddyy = 'MMM dd yyyy';
  static const String yyyymmdd = 'yyyy-MM-dd';

  static const List<String> taskPriority = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ];

  static const int dueDateFromNowInDays = 30;

  static const List<Map<String, dynamic>> walkthroughData = [
    {
      "title": "Organize Your Workflow, Effortlessly",
      "description":
          "Visualize tasks in customizable boards.\nTrack progress and manage deadlines seamlessly.",
      "image": AppImages.walkthrough1
    },
    {
      "title": "Your Workflow, Your Rules",
      "description":
          "Drag and drop tasks between stages. \nSet priorities, deadlines, and assign team members to tasks.",
      "image": AppImages.walkthrough2
    },
    {
      "title": "Teamwork Made Simple",
      "description":
          "Share boards and collaborate in real-time.\nGet notifications on updates and stay aligned with your team.",
      "image": AppImages.walkthrough3
    }
  ];

  static const String durationKey = "mins";
}
