import 'package:bmi/app/widgets/app_button.dart';
import 'package:bmi/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class ScoreScreen extends StatelessWidget {
  final double bmiScore;

  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  ScoreScreen({super.key, required this.bmiScore});

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BMI Score"),
      ),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
                elevation: 12,
                shape: const RoundedRectangleBorder(),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Your Score",
                          style: TextStyle(fontSize: 30, color: AppColors.primaryColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PrettyGauge(
                          gaugeSize: 250,
                          minValue: 0,
                          maxValue: 40,
                          segments: [
                            GaugeSegment('UnderWeight', 18.5, Colors.red),
                            GaugeSegment('Normal', 6.4, Colors.green),
                            GaugeSegment('OverWeight', 5, Colors.orange),
                            GaugeSegment('Obese', 10.1, Colors.pink),
                          ],
                          valueWidget: Text(
                            bmiScore.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 40),
                          ),
                          currentValue: bmiScore.toDouble(),
                          needleColor: Colors.blue,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          bmiStatus!,
                          style: TextStyle(fontSize: 20, color: bmiStatusColor!),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          bmiInterpretation!,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppButton(onTap: () {
                          Navigator.pop(context);
                        }, text: "Re-calculate")
                      ]),
                )),
          )),
    );
  }

  void setBmiInterpretation() {
    if (bmiScore > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = Colors.pink;
    } else if (bmiScore >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy, You are fit";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "Underweight";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = Colors.red;
    }
  }
}