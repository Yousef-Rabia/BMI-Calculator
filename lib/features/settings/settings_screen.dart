import 'package:bmi/app/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/widgets/change_lang_widget.dart';
import '../../theme/app_colors.dart';
import '../auth/data/providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr(),style: TextStyle(color: AppColors.primaryColor, fontSize: 15.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            AppButton(
              text: 'changeLang'.tr(),
              bgcolor: AppColors.primaryColor,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 80.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const ChangeLangWidget(),
                      ],
                    );
                  },
                );
              },
            ),
            const Spacer(),
            AppButton(
              text: 'logout'.tr(),
              bgcolor: AppColors.red,
              onTap: () {
                ref.read(authNotifierProvider.notifier).logout();
              },
            ),
            SizedBox(height: 70.h,),
          ],
        ),
      ),
    );
  }
}
