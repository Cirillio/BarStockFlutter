sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success;
  bool get isFailure => this is Failure;
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  final String? code;
  const Failure(this.message, {this.code});
}
