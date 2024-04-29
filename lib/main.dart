import 'package:bmi/utils/hive_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await HiveManager.initHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RootApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInScreen({super.key});

  void _signInAnonymously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in anonymously: $e');
      }
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInAnonymously(context),
          child: const Text('Sign In Anonymously'),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputScreen()),
                );
              },
              child: const Text('Enter BMI Data'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EntriesScreen()),
                );
              },
              child: const Text('View Entries'),
            ),
          ],
        ),
      ),
    );
  }
}

class InputScreen extends StatelessWidget {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  InputScreen({super.key});

  void _submitData(BuildContext context) async {
    try {
      final double weight = double.parse(weightController.text);
      final double height = double.parse(heightController.text);
      final int age = int.parse(ageController.text);

      // Calculate BMI
      double bmi = weight / (height * height);

      // Save data to Firestore
      await FirebaseFirestore.instance.collection('bmi_data').add({
        'weight': weight,
        'height': height,
        'age': age,
        'bmi': bmi,
        'timestamp': Timestamp.now(),
      });

      // Navigate back to home screen
      Navigator.pop(context);
    } catch (e) {
      print('Error submitting data: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter BMI Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Height (m)'),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _submitData(context),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class EntriesScreen extends StatelessWidget {
  const EntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Entries'),
      ),
      body: StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        stream: FirebaseFirestore.instance.collection('bmi_data').snapshots().map((snapshot) => snapshot.docs),
        builder: (context, AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>> snapshot) {


          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final entries = snapshot.data ?? [];
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final data = entries[index].data();
              final double weight = data['weight'];
              final double height = data['height'];
              final int age = data['age'];
              final double bmi = data['bmi'];

              String bmiStatus = '';
              if (bmi < 18.5) {
                bmiStatus = 'Underweight';
              } else if (bmi >= 18.5 && bmi < 25) {
                bmiStatus = 'Normal weight';
              } else if (bmi >= 25 && bmi < 30) {
                bmiStatus = 'Overweight';
              } else {
                bmiStatus = 'Obese';
              }

              return ListTile(
                title: Text('Weight: $weight kg, Height: $height m, Age: $age'),
                subtitle: Text('BMI: $bmi - Status: $bmiStatus'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance.collection('bmi_data').doc(entries[index].id).delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}


