import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:progresspallet/common/toast/custom_flutter_toast.dart';
import 'package:progresspallet/common/widgets/common_loading_indicator.dart';
import 'package:progresspallet/common/widgets/common_no_data_view.dart';
import 'package:progresspallet/common/widgets/common_sized_boxes.dart';
import 'package:progresspallet/common/widgets/common_slider_comp.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/constants/analytics_key_constats.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/string_keys.dart';
import 'package:progresspallet/dependency_injection/injection_container.dart';
import 'package:progresspallet/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:progresspallet/feature/dashboard/bloc/dashboard_event.dart';
import 'package:progresspallet/feature/dashboard/bloc/dashboard_state.dart';
import 'package:progresspallet/feature/dashboard/data/model/project_list/project_list_response_model.dart';
import 'package:progresspallet/feature/dashboard/view/components/project_card.dart';
import 'package:progresspallet/routing/routes_constants.dart';
import 'package:progresspallet/utils/firebase_analytics_utils.dart';
import 'package:progresspallet/utils/localization/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashboardBloc = sl<DashboardScreenBloc>();
  List<Project> projectsList = [];
  @override
  void initState() {
    dashboardBloc.add(const DashboardDataFetchEvent());
    super.initState();
    AnalyticsUtils().trackScreen(screenName: AppAnalyticsKey.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DashboardScreenBloc, DashboardScreenState>(
        listener: (context, state) {},
        bloc: dashboardBloc,
        builder: (context, state) {
          if (state is DashboardScreenError) {
            CustomFlutterToast.showToast(state.message ?? "");
          }
          if (state is DashboardScreenSuccess) {
            projectsList = state.model?.projects ?? [];
          }

          return Stack(
            children: [
              buildUi(),
              Visibility(
                visible: state is DashboardScreenLoading,
                child: const CommonLoadingIndicator(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildUi() {
    return SizedBox(
      height: AppSizes.getHeight(context),
      width: AppSizes.getWidth(context),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          largeSizedBox(),
          const CommonSliderWidget(
            bannerImages: AppConstants.bannerArray,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: AppDimens.dp15),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimens.dp30),
                  topRight: Radius.circular(AppDimens.dp30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: projectsList.isEmpty
                  ? const CommonNoDataView()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        smallSizedBox(),
                        CommonTextWidget(
                          text: AppLocalizations.of(context)
                                  ?.translate(StringKeys.yourProject) ??
                              "",
                          textStyle: textStyleMonumentFontW600.copyWith(
                            fontSize: AppDimens.dp14,
                            color: AppColors.textSecondaryColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: projectsList.length,
                          itemBuilder: (BuildContext context, i) {
                            return ProjectsCardView(
                              projectInfo: projectsList[i],
                              onTapProject: () {
                                context.push(Routes.getRoutes(Routes.task),
                                    extra: {
                                      "id": projectsList[i].id,
                                    });
                              },
                            );
                          },
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
