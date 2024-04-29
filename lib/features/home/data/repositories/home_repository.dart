import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class HomeRepository {
  Future<void> submitData({required double weight, required double height, required double bmi, required int age});
}

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<void> submitData({required double weight, required double height, required double bmi, required int age}) async {
    try {
      await FirebaseFirestore.instance.collection('bmi_data').add({
        'weight': weight,
        'height': height,
        'age': age,
        'bmi': bmi,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      rethrow;
    }
  }
}

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl();
});
