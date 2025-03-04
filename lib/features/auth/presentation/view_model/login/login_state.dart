class LoginState {
  final bool isLoading;
  final bool isSuccess;

  LoginState({
    required this.isLoading,
    required this.isSuccess,
  });

  // Override == and hashCode for proper comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess;
  }

  @override
  int get hashCode => isLoading.hashCode ^ isSuccess.hashCode;

  LoginState.initial()
      : isLoading = false,
        isSuccess = false;

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
