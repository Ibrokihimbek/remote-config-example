import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_config_firebase/firebase/firebase_remote_config_service.dart';
import 'package:remote_config_firebase/home_bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(
              remoteConfig: FirebaseRemoteConfig.instance,

          ),
      child: const HomePageBody(),
    );
  }
}


class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const CheckAppVersionEvent());
  }

  Future<void> _pullRefresh() async {
    context.read<HomeBloc>().add(const CheckAppVersionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.isValidAppVersion) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Update Available'),
                content: const Text('Please update the app to continue'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: _pullRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                color: Colors.lightBlueAccent,
                width: 500,
                height: 500,
                child: Center(
                  child: Text(state.appVersion, style: const TextStyle(fontSize: 24),),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
