import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.remoteConfig}) : super(const HomeState()) {
    on<CheckAppVersionEvent>(_onVersionCheck);
  }

  final FirebaseRemoteConfig remoteConfig;

  Future<void> _onVersionCheck(
      CheckAppVersionEvent event, Emitter<HomeState> emit) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String newAppVersionAndroid =
        remoteConfig.getString('update_version_android');
    String newAppVersionIos = remoteConfig.getString('update_version_ios');
    emit(state.copyWith(
      appVersion: packageInfo.version,
      configVersionAndroid: newAppVersionAndroid,
      configVersionIos: newAppVersionIos,
    ));
    debugPrint('---> Current version ${packageInfo.version}');
    debugPrint('---> Config version Android $newAppVersionAndroid');
    debugPrint('---> Config version iOS $newAppVersionIos');
    if (Platform.isAndroid) {
      debugPrint('------------------------ Android --------------');
      if (packageInfo.version != newAppVersionAndroid) {
        debugPrint('---> IF Current version Android ${packageInfo.version}');
        debugPrint('---> IF Config version Android $newAppVersionAndroid');
        emit(state.copyWith(
          isValidAppVersionAndroid: !state.isValidAppVersionAndroid,
        ));
        debugPrint(
            '---> Is valid app version Android ${state.isValidAppVersionAndroid}');
      }
    } else {
      debugPrint('------------------------ iOS --------------');
      if (packageInfo.version != newAppVersionIos) {
        debugPrint('---> Current version iOS ${packageInfo.version}');
        debugPrint('---> Config version iOS $newAppVersionIos');
        emit(state.copyWith(
          isValidAppVersionIos: !state.isValidAppVersionIos,
        ));
        debugPrint(
            '---> Is valid app version iOS ${state.isValidAppVersionIos}');
      }
    }
  }
}
