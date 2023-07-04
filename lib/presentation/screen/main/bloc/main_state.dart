class MainState {
  final int index;
  final int badge;

  MainState({int? index, int? badge})
      : index = index ?? 0,
        badge = badge ?? 0;

  MainState copyWith({
    int? index,
    int? badge,
  }) {
    return MainState(
      index: index ?? this.index,
      badge: badge ?? this.badge,
    );
  }
}
