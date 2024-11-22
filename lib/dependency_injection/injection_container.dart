import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:progresspallet/core/firebase_remote_config.dart';
import 'package:progresspallet/core/logs.dart';
import 'package:progresspallet/core/system_settings.dart';
import 'package:progresspallet/domain/usecases/add_task_usecase.dart';
import 'package:progresspallet/domain/usecases/get_project_usecase.dart';
import 'package:progresspallet/domain/usecases/get_task_comments_usecase.dart';
import 'package:progresspallet/domain/usecases/get_task_detail_usecase.dart';
import 'package:progresspallet/domain/usecases/get_task_list_usecase.dart';
import 'package:progresspallet/domain/usecases/post_comment_usecase.dart';
import 'package:progresspallet/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:progresspallet/feature/dashboard/data/remote_data_source/dashboard_data_source.dart';
import 'package:progresspallet/feature/dashboard/data/repository/dashboard_repository.dart';
import 'package:progresspallet/feature/task/bloc/task_bloc.dart';
import 'package:progresspallet/feature/task/data/data_source/task_data_source.dart';
import 'package:progresspallet/feature/task/data/repository/task_repository.dart';
import 'package:progresspallet/feature/task_detail/bloc/task_detail_bloc.dart';
import 'package:progresspallet/feature/task_detail/data/data_source/task_detail_data_source.dart';
import 'package:progresspallet/feature/task_detail/data/repository/task_detail_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  const String mode =
      String.fromEnvironment('progresspallet_MODE', defaultValue: 'develop');

  printMessage('mode $mode');

  if (Firebase.apps.isEmpty) {
    await Future.wait([
      Firebase.initializeApp(),
    ]).then((value) {});
  } else {}
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await SystemSettings.makeAppBarColored();
  await SystemSettings.setAppOrientation();

  sl

    // DataSource
    ..registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(dio: sl<Dio>()),
    )
    ..registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(dio: sl<Dio>()),
    )
    ..registerLazySingleton<TaskDetailRemoteDataSource>(
      () => TaskDetailRemoteDataSourceImpl(dio: sl<Dio>()),
    )

    // Repository
    ..registerLazySingleton<DashboardScreenRepository>(
      () => DashboardScreenRepositoryImpl(
        remoteDataSource: sl<DashboardRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton<TaskScreenRepository>(
      () => TaskScreenRepositoryImpl(
        remoteDataSource: sl<TaskRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton<TaskDetailScreenRepository>(
      () => TaskDetailScreenRepositoryImpl(
        remoteDataSource: sl<TaskDetailRemoteDataSource>(),
      ),
    )

    //Gobal key
    ..registerLazySingleton<GlobalKey<ScaffoldMessengerState>>(
      () => GlobalKey<ScaffoldMessengerState>(),
    )

    // UseCases
    ..registerLazySingleton<GetProjectUsecase>(
      () => GetProjectUsecase(sl<DashboardScreenRepository>()),
    )
    ..registerLazySingleton<GetTaskListUsecase>(
      () => GetTaskListUsecase(sl<TaskScreenRepository>()),
    )
    ..registerLazySingleton<GetTaskDetailUsecase>(
      () => GetTaskDetailUsecase(sl<TaskDetailScreenRepository>()),
    )
    ..registerLazySingleton<GetTaskCommentsUsecase>(
      () => GetTaskCommentsUsecase(sl<TaskDetailScreenRepository>()),
    )
    ..registerLazySingleton<PostCommentsUsecase>(
      () => PostCommentsUsecase(sl<TaskDetailScreenRepository>()),
    )
    ..registerLazySingleton<AddTaskUsecase>(
      () => AddTaskUsecase(sl<TaskScreenRepository>()),
    )

    // bloc
    ..registerLazySingleton<DashboardScreenBloc>(
      () => DashboardScreenBloc(
        getProjectUsecase: sl<GetProjectUsecase>(),
      ),
    )
    ..registerLazySingleton<TaskListScreenBloc>(
      () => TaskListScreenBloc(
        getTaskListUsecase: sl<GetTaskListUsecase>(),
        addTaskUsecase: sl<AddTaskUsecase>(),
      ),
    )
    ..registerLazySingleton<TaskDetailScreenBloc>(
      () => TaskDetailScreenBloc(
        getTaskDetailUsecase: sl<GetTaskDetailUsecase>(),
        getTaskCommentsUsecase: sl<GetTaskCommentsUsecase>(),
        postCommentsUsecase: sl<PostCommentsUsecase>(),
      ),
    )

    //! External
    ..registerLazySingleton<Dio>(() {
      final dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 60);
      dio.options.receiveTimeout = const Duration(seconds: 60);

      // Open comment code if you need view log request
      if (!kReleaseMode) {
        dio.interceptors.add(
          LogInterceptor(
            responseBody: true,
            requestHeader: true,
            requestBody: true,
          ),
        );
      }
      return dio;
    });
  Future.wait([FirebaseRemoteConfigService().initialize()]);
}
