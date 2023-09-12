part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.isValidAppVersionAndroid = false,
    this.appVersion = '',
    this.isValidAppVersionIos = false,
    this.configVersionAndroid = '',
    this.configVersionIos = '',
});
  final bool isValidAppVersionAndroid;
  final bool isValidAppVersionIos;
  final String appVersion;
  final String configVersionAndroid;
  final String configVersionIos;

  HomeState copyWith({
    bool? isValidAppVersionAndroid,
    String? appVersion,
    bool? isValidAppVersionIos,
    String? configVersionAndroid,
    String? configVersionIos,
  }) {
    return HomeState(
      isValidAppVersionAndroid: isValidAppVersionAndroid ?? this.isValidAppVersionAndroid,
      appVersion: appVersion ?? this.appVersion,
      isValidAppVersionIos: isValidAppVersionIos ?? this.isValidAppVersionIos,
      configVersionAndroid: configVersionAndroid ?? this.configVersionAndroid,
      configVersionIos: configVersionIos ?? this.configVersionIos,
    );
  }

  @override
  List<Object> get props => [
    isValidAppVersionAndroid,
    appVersion,
    isValidAppVersionIos,
    configVersionAndroid,
    configVersionIos,
  ];
}
