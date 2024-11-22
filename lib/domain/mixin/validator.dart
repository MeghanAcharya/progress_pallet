import 'package:progresspallet/constants/app_strings.dart';

mixin Validator {
  String? validateEmptyMessage(String? value, String header) {
    if (value == null || value.trim().isEmpty) {
      return "$header ${AppStrings.isRequiredText}";
    }
    return null;
  }
}
