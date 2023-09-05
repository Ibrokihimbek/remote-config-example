import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
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
    String newAppVersion = remoteConfig.getString('update_version');
    emit(state.copyWith(appVersion: packageInfo.version));
    print('Update Available <---> ${packageInfo.version} --> new $newAppVersion');
    if (packageInfo.version != newAppVersion) {
      print('Update Available ${packageInfo.version} --> new $newAppVersion');
      emit(state.copyWith(
        isValidAppVersion: !state.isValidAppVersion,
      ));
      print('Update Available 99999 ${state.isValidAppVersion}');
    }
  }
}
