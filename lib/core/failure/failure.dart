class AppFailure {
  final String message;
  AppFailure([this.message = 'Sorry, an unexpected error occurred!']);

  @override
  String toString() {
    return 'AppFailure: $message';
  }
}
