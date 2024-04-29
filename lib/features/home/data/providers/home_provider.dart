import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/home_repository.dart';
import '../states/home_state.dart';

class HomeNotifierProvider extends StateNotifier<HomeState> {
  HomeNotifierProvider(this.homeRepository) : super(const HomeState());

  final HomeRepository homeRepository;

  submitData({required double weight, required double height, required int age}) async {
    try {
      double bmi = (weight / ((height / 100) * (height / 100)));
      await homeRepository.submitData(weight: weight, height: height, bmi: bmi, age: age);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  changePageIndex(index) {
    state = state.copyWith(screenIndex: index);
  }
}

final homeNotifierProvider =
    StateNotifierProvider<HomeNotifierProvider, HomeState>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);

  return HomeNotifierProvider(homeRepository);
});
