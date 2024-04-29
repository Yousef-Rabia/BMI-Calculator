import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/widgets/app_button.dart';
import '../../../theme/app_assets.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/utils.dart';
import '../data/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget{

  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authNotifierProvider);
    ref.listen(authNotifierProvider.select((value) => value.errorMessage),
            (previous, nextErrorMessage) {
          if (nextErrorMessage != null && nextErrorMessage != '') {
            AppSnackbar.show(buildSnackBar(text: nextErrorMessage));
          }
        });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 25, left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'welcomeBack'.tr(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      // Add your login button here
                      AppButton(
                        txtstyle: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                        bgcolor: AppColors.primaryColor,
                        height: 50.h,
                        text: "anonymousLogin".tr(),
                        loading: auth.loading,
                        onTap: () async {

                            final result = await ref
                                .read(authNotifierProvider.notifier)
                                .anonymousLogin();

                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.311, // Adjust the top position as needed
              left: 0,
              right: 0,
              child: Image.asset(
                AppAssets.logo,
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


