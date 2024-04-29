import 'package:bmi/app/app_keys.dart';
import 'package:bmi/app/routes.dart';
import 'package:bmi/app/widgets/app_button.dart';
import 'package:bmi/app/widgets/text_field.dart';
import 'package:bmi/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/utils.dart';
import '../data/providers/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Tracker'.tr(),style: TextStyle(color: AppColors.primaryColor, fontSize: 15.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: AppKeys.bmiFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("enterBMI".tr(),style: TextStyle(color: AppColors.primaryColor, fontSize: 15.sp,fontWeight: FontWeight.bold),),
              SizedBox(height: 25.h,),
              AppTextField(hintText: "weight".tr(), suffixIcon: const Icon(Icons.accessibility ), controller: weightController,textInputType: TextInputType.number, validator: (data){
                if(data!.isEmpty){
                  return "pleaseEnterWeight".tr();
                }else if(double.tryParse(data)==null){
                  return "pleaseEnterValidWeight".tr();
                }
                else if(double.parse(data) < 0){
                  return "pleaseEnterValidWeight".tr();
                }
                return null;
              },),
              SizedBox(height: 10.h,),
              AppTextField(hintText: "height".tr(), suffixIcon: const Icon(Icons.height ), controller: heightController,textInputType: TextInputType.number, validator: (data){
                if(data!.isEmpty){
                  return "pleaseEnterHeight".tr();
                }else if(double.tryParse(data)==null){
                  return "pleaseEnterValidHeight".tr();
                }
                else if(double.parse(data) < 0){
                  return "pleaseEnterValidHeight".tr();
                }
                return null;
              },),
              SizedBox(height: 10.h,),
              AppTextField(hintText: "age".tr(), suffixIcon: const Icon(Icons.alarm), controller: ageController,textInputType: TextInputType.number, validator: (data){
                if(data!.isEmpty){
                  return "pleaseEnterAge".tr();
                }else if(int.tryParse(data)==null){
                  return "pleaseEnterValidAge".tr();
                }
                else if(int.parse(data) < 0){
                  return "pleaseEnterValidAge".tr();
                }
                return null;
              },),
              SizedBox(height: 25.h,),
              AppButton(onTap: () async {
                if(AppKeys.bmiFormKey.currentState!.validate()){
                  double weight = double.parse(weightController.text.trim());
                  double height = double.parse(heightController.text.trim());
                  int age = int.parse(ageController.text.trim());
                  var result= await ref
                      .read(homeNotifierProvider.notifier)
                      .submitData(
                      weight: weight,
                      height: height,
                      age: age);
                  if(result!=true) {
                    AppSnackbar.show(buildSnackBar(text: "error".tr()));
                    return;
                  }
                  weightController.clear();
                  heightController.clear();
                  ageController.clear();
                  AppSnackbar.show(buildSnackBar(text: "success".tr(),backgroundColor: AppColors.green6E));

                  Navigator.pushNamed(context, Routes.scoreScreen,arguments: (weight / ((height / 100) * (height / 100))));
                }
              }, text: "submit",),
            ],
          ),
        ),
      ),
    );
  }
}