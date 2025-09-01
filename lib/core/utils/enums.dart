import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum SnackBarStatus {
  success(color: AppColors.success),
  error(color: AppColors.error),
  warning(color: AppColors.warning);

  const SnackBarStatus({required this.color});

  final Color color;
}
