/// Result class will be used to hold result of network call which can be
/// success (with data) or failure (with error information)
class Result<T> with SealedResult<T> {
  bool get isSuccess => this is Success;

  T get data => isSuccess ? (this as Success).data : null;

  String get error => !isSuccess ? (this as Error).error : '';
}

class Success<T> extends Result<T> {
  T data;

  Success(this.data);
}

class Error<T> extends Result<T> {
  String error;

  Error(this.error);
}

abstract class SealedResult<T> {
  R when<R>({
    required R Function(T) success,
    required R Function(String) error,
    R Function(String)? unauthorized,
  }) {
    if (this is Success<T>) {
      return success.call(((this as Success).data));
    }
    if (this is Error<T>) {
      return error.call(((this as Error<T>).error));
    }
    throw Exception(
        'If you got here, probably you forgot to regenerate the classes? Try running flutter packages pub run build_runner build');
  }
}
