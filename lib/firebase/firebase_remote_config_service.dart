import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> fireBaseRemoteConfigInit() async {
  FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  try {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ),
    );
    await remoteConfig.fetch();
    await remoteConfig.activate();
    await remoteConfig.fetchAndActivate();
  } on Exception {
    rethrow;
  }
}