part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.isValidAppVersion = false,
    this.appVersion = '',
});
  final bool isValidAppVersion;
  final String appVersion;

  HomeState copyWith({
    bool? isValidAppVersion,
    String? appVersion,
  }) {
    return HomeState(
      isValidAppVersion: isValidAppVersion ?? this.isValidAppVersion,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object> get props => [
    isValidAppVersion,
    appVersion,
  ];
}
