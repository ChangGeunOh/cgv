
class SplashState {
  final bool isFinish;

  SplashState({
    bool? isFinish,
  }) : isFinish = isFinish ?? false;

  SplashState copyWith({bool? isFinish}) {
    return SplashState(
      isFinish: isFinish ?? this.isFinish,
    );
  }
}
