import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.onTap,
      this.loading = false,
      required this.text,
      this.width,
      this.bgcolor,
      this.txtstyle,
      this.height,
      this.heightPadding});

  final Function onTap;
  final bool loading;
  final String text;
  final double? width;
  final Color? bgcolor;
  final TextStyle? txtstyle;
  final double? heightPadding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Material(
        color: bgcolor ?? AppColors.primaryColor,
        borderRadius: BorderRadius.circular(7.r),
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(7.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: heightPadding ?? 15.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.r),
            ),
            child: Center(
              child: loading
                  ? SizedBox(
                      width: 16.h,
                      height: 16.h,
                      child: const CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 1,
                      ),
                    )
                  : Text(
                      text.tr(),
                      style: txtstyle ??
                          TextStyle(
                              color: AppColors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
