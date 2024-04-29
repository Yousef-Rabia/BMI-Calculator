import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../theme/app_colors.dart';

class EntriesScreen extends StatefulWidget {
  const EntriesScreen({super.key});

  @override
  State<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends State<EntriesScreen> {
  final int _perPage = 10;
  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  late List<DocumentSnapshot> _documents;
  final RefreshController _controller = RefreshController();

  @override
  void initState() {
    super.initState();
    _documents = [];
    _loadData(loading: false);
    Future.delayed(const Duration(seconds: 0), () async {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Data'.tr(),style: TextStyle(color: AppColors.primaryColor, fontSize: 15.sp,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SmartRefresher(
        controller: _controller,
        enablePullDown: false,
        enablePullUp: true,
        footer: ClassicFooter(
          loadingText: 'loadingMore'.tr(),
        ),
        onLoading: _loadData,
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final entries = _documents;
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final data = entries[index];
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
  }

  Future<void> _loadData({bool loading=true}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      if(loading) _isLoading = false;
    });

    Query query = FirebaseFirestore.instance.collection('bmi_data').orderBy(
        'timestamp');

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    query = query.limit(_perPage);

    QuerySnapshot querySnapshot = await query.get();

    setState(() {
      _documents.addAll(querySnapshot.docs);
      _lastDocument =
      querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
      _isLoading = false;
      if(querySnapshot.docs.isEmpty) {
        _controller.loadNoData();
      } else {
        _controller.loadComplete();
      }
    });
  }
}

