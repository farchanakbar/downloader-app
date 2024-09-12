import 'package:app_downloader/app.dart';
import 'package:app_downloader/general_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() async {
  Bloc.observer = MyObserver();
  runApp(const MyApp());
}
