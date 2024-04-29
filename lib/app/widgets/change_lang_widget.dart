import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/auth/data/providers/auth_provider.dart';
import '../../theme/app_colors.dart';



class ChangeLangWidget extends StatefulHookConsumerWidget {
  const ChangeLangWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangeLangWidgetState();
}

class _ChangeLangWidgetState extends ConsumerState<ChangeLangWidget> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      ref
          .read(authNotifierProvider.notifier)
          .setAppLang(context.locale.languageCode);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);
    return Column(
      children: [
        SizedBox(
          height: 62.h,
        ),

        Center(
          child: Text(
            "selectLang".tr(),
            style: TextStyle(
                color: AppColors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 22.h,
        ),
        Divider(endIndent: 70,indent: 70,color: AppColors.primaryColor.withOpacity(0.3),thickness: 1.5,),
        SizedBox(
          height: 42.h,
        ),
        //ARABIC row
        InkWell(
          onTap: () {
            ref.read(authNotifierProvider.notifier).setAppLang("ar");
            context.setLocale(const Locale("ar"));
          },
          child: Row(
            children: [
              SizedBox(
                width: 54.w,
              ),

              Text(
                "arLang".tr(),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Visibility(
                visible: auth.appLang == "ar",
                child: const Icon(
                  Icons.check,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
        ),

        SizedBox(
          height: 25.h,
        ),

        // ENGLISH lang
        InkWell(
          onTap: () {
            ref.read(authNotifierProvider.notifier).setAppLang("en");
            context.setLocale(const Locale("en"));
          },
          child: Row(
            children: [
              SizedBox(
                width: 54.w,
              ),

              Text(
                "enLang".tr(),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Visibility(
                visible: auth.appLang == "en",
                child: const Icon(
                  Icons.check,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
