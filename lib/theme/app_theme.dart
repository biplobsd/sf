import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static final headLineLarge32Colored = GoogleFonts.hindSiliguri(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.watermelon100);

  static final titleExtraSmall14 = GoogleFonts.hindSiliguri(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  static final titleTiny12 = GoogleFonts.hindSiliguri(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );

  static final titleExtraTiny10 = GoogleFonts.hindSiliguri(
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
  );

  static final bodyMedium14 = GoogleFonts.hindSiliguri(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final bodySmall12 = GoogleFonts.hindSiliguri(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  static final bodySmall10 = GoogleFonts.hindSiliguri(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  );

  static final bodySmall8 = GoogleFonts.hindSiliguri(
    fontSize: 8.sp,
    fontWeight: FontWeight.w400,
  );

  static final bodySmall12Colored = GoogleFonts.hindSiliguri(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.watermelon100);
}
