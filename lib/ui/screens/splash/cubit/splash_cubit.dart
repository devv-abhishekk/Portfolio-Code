import '../../../../app_export.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void initSplash() async {
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 3));
    emit(SplashLoaded());
  }
}
