class Failure {
  String message = 'An unexpected error occurred';

  Failure(this.message);

  @override
  String toString() {
    return 'Failure{message: $message}';
  }
}
