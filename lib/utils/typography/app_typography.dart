import 'package:flutter/cupertino.dart';
import 'package:xvitamins/utils/colors/colors.dart';

abstract class AppTypography{
  static const TextStyle medium = TextStyle(
    fontFamily: 'InterMedium',
    color: AppColors.black,
  );
  static const TextStyle semibold = TextStyle(
    fontFamily: 'InterSemi',
    color: AppColors.black,
  );
  static const TextStyle bold = TextStyle(
    fontFamily: 'InterBold',
    color: AppColors.black,
  );
  static const TextStyle regular = TextStyle(
    fontFamily: 'InterRegular',
    color: AppColors.black,
  );
}