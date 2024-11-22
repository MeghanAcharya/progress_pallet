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
      {"statusCode": "2", "status": "Todo"},
      {"statusCode": "4", "status": "In progress"},
      {"statusCode": "6", "status": "Completed"}
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
}
