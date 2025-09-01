
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
		static ThemeData get lightTheme {
			return ThemeData(
        primarySwatch: Colors.green,
				brightness: Brightness.light,
				scaffoldBackgroundColor: AppColors.background,
				fontFamily: 'Roboto',
				textTheme: const TextTheme(
					headlineLarge: TextStyle(color: AppColors.text),
					headlineMedium: TextStyle(color: AppColors.text),
					headlineSmall: TextStyle(color: AppColors.text),
					bodyLarge: TextStyle(color: AppColors.text),
					bodyMedium: TextStyle(color: AppColors.text),
					bodySmall: TextStyle(color: AppColors.textLight),
				),
				appBarTheme: const AppBarTheme(
					backgroundColor: AppColors.surface,
					foregroundColor: AppColors.text,
					elevation: 0,
				),
				snackBarTheme: const SnackBarThemeData(
					backgroundColor: AppColors.text,
					contentTextStyle: TextStyle(color: AppColors.surface),
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.all(Radius.circular(8)),
					),
				),
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.background,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
          linearTrackColor: AppColors.surface,
          circularTrackColor: AppColors.surface,
        ),
				colorScheme: ColorScheme(
					brightness: Brightness.light,
					primary: AppColors.primary,
					onPrimary: AppColors.text,
					secondary: AppColors.secondary,
					onSecondary: AppColors.text,
					error: AppColors.error,
					onError: AppColors.surface,
					surface: AppColors.surface,
					onSurface: AppColors.text,
				),
			);
	}
}
