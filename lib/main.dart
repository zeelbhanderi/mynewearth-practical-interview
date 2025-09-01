import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/bindings/initial_bindings.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/custom_snackbar.dart';
import 'features/offerings/presentation/pages/offerings_list_page.dart';

void main() {
  runApp(const WellnessApp());
}

class WellnessApp extends StatelessWidget {
  const WellnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: CustomSnackBar.scaffoldMessengerKey,
      initialBinding: InitialBindings(),
      theme: AppTheme.lightTheme,
      home: const OfferingsListPage(),
    );
  }
}