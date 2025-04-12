import 'package:flutter_test/flutter_test.dart';
import 'package:vaxio/Vue/Loading_page/loading_cubit.dart';

void main() {
  group('LoadingCubit Tests', () {
    test('Initial state should be false', () {
      final cubit = LoadingCubit();
      expect(cubit.state, false);
    });

    test('State should be true after startLoading is called', () async {
      final cubit = LoadingCubit();
      cubit.startLoading();
      await Future.delayed(const Duration(milliseconds: 500));
      expect(cubit.state, true);
    });

    test('State should be false after loading completes', () async {
      final cubit = LoadingCubit();
      cubit.startLoading();
      await Future.delayed(const Duration(seconds: 2));
      expect(cubit.state, false);
    });
  });
}