import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/screens/home_screen.dart';
import 'package:space_scutum_test_task/theme.dart';
import 'package:space_scutum_test_task/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setOrientation();
  await setUIMode();
  await hideSystemUi();
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: const HomeScreen(),
        theme: defaultTheme,
      ),
    ),
  );
}
