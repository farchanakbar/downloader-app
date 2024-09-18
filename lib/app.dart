import 'package:app_downloader/bloc/facebook/facebook_bloc.dart';
import 'package:app_downloader/bloc/gdrive/gdrive_bloc.dart';
import 'package:app_downloader/bloc/instagram/instagram_bloc.dart';
import 'package:app_downloader/bloc/mediafire/mediafire_bloc.dart';
import 'package:app_downloader/bloc/tiktok/tiktok_bloc.dart';
import 'package:app_downloader/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TiktokBloc(),
        ),
        BlocProvider(
          create: (context) => InstagramBloc(),
        ),
        BlocProvider(
          create: (context) => FacebookBloc(),
        ),
        BlocProvider(
          create: (context) => MediafireBloc(),
        ),
        BlocProvider(
          create: (context) => GdriveBloc(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
