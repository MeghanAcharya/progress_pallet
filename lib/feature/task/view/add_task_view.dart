import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:progresspallet/common/toast/custom_flutter_toast.dart';
import 'package:progresspallet/common/widgets/common_app_bar.dart';
import 'package:progresspallet/common/widgets/common_button.dart';
import 'package:progresspallet/common/widgets/common_loading_indicator.dart';
import 'package:progresspallet/common/widgets/common_sized_boxes.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/common/widgets/common_textfield_widget.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_strings.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/string_keys.dart';
import 'package:progresspallet/dependency_injection/injection_container.dart';
import 'package:progresspallet/domain/mixin/validator.dart';
import 'package:progresspallet/feature/task/bloc/task_bloc.dart';
import 'package:progresspallet/feature/task/bloc/task_event.dart';
import 'package:progresspallet/feature/task/bloc/task_state.dart';
import 'package:progresspallet/feature/task/data/model/add_task/add_task_request_data.dart';
import 'package:progresspallet/utils/localization/app_localizations.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> with Validator {
  final taskBloc = sl<TaskListScreenBloc>();
  String selectedPriority = "1";
  final formKey = GlobalKey<FormState>();
  TextEditingController titleTextEditController = TextEditingController();
  TextEditingController descTextEditController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        context: context,
        titleText:
            AppLocalizations.of(context)?.translate(StringKeys.addTask) ?? "",
      ),
      body: BlocConsumer<TaskListScreenBloc, TaskListScreenState>(
        listener: (context, state) {},
        bloc: taskBloc,
        builder: (context, state) {
          if (state is TaskScreenError) {
            CustomFlutterToast.showToast(state.message ?? "");
          }
          if (state is AddTaskSuccess) {
            CustomFlutterToast.showToast(AppStrings.taskAddedMessage);
            context.pop();
          }
          if (state is ScreenStateUpdate) {}

          return Stack(
            children: [
              buildUi(),
              Visibility(
                visible: state is TaskScreenLoading,
                child: const CommonLoadingIndicator(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildUi() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.dp20,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextFieldWidget(
              hintText: AppLocalizations.of(context)
                      ?.translate(StringKeys.enterTitle) ??
                  "",
              label: AppLocalizations.of(context)
                      ?.translate(StringKeys.enterTitle) ??
                  "",
              withAsterisk: true,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              controller: titleTextEditController,
              focusNode: titleFocusNode,
              validator: (value) {
                return validateEmptyMessage(
                    value,
                    AppLocalizations.of(context)
                            ?.translate(StringKeys.enterTitle) ??
                        "");
              },
            ),
            extraSmallSizedBox(),
            CommonTextFieldWidget(
              hintText: AppLocalizations.of(context)
                      ?.translate(StringKeys.enterDesc) ??
                  "",
              label: AppLocalizations.of(context)
                      ?.translate(StringKeys.enterDesc) ??
                  "",
              withAsterisk: true,
              controller: descTextEditController,
              focusNode: descFocusNode,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return validateEmptyMessage(
                    value,
                    AppLocalizations.of(context)
                            ?.translate(StringKeys.enterDesc) ??
                        "");
              },
            ),
            smallSizedBox(),
            CommonTextWidget(
              text: AppLocalizations.of(context)
                      ?.translate(StringKeys.priority) ??
                  "",
              textStyle: textStyleMonumentFontW600.copyWith(
                fontSize: AppDimens.dp10,
                color: AppColors.lightGreyColor,
              ),
            ),
            extraSmallSizedBox(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: AppColors.greyColor),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: CommonTextWidget(
                    text: AppLocalizations.of(context)
                            ?.translate(StringKeys.priority) ??
                        "",
                  ),
                  value: selectedPriority,
                  onChanged: (value) {
                    selectedPriority = value ?? "1";
                    taskBloc.add(DropdownStateUpdateEvent(value));
                  },
                  items: AppConstants.taskPriority.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: CommonTextWidget(text: value),
                    );
                  }).toList(),
                ),
              ),
            ),
            smallSizedBox(),
            CommonButton(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (formKey.currentState?.validate() ?? false) {
                  taskBloc.add(
                    AddTaskEvent(
                      AddTaskRequestData(
                        content: titleTextEditController.text.trim(),
                        description: descTextEditController.text.trim(),
                        priority: int.parse(selectedPriority),
                      ),
                    ),
                  );
                }
              },
              buttonColor: AppColors.primary,
              borderColor: AppColors.primary,
              buttonTitle:
                  AppLocalizations.of(context)?.translate(StringKeys.save) ??
                      "",
            )
          ],
        ),
      ),
    );
  }
}