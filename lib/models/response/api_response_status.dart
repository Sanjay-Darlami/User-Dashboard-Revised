class ApiResponseStatus<T> {
  final T? data;
  final String? error;
  final bool isSuccessful;
  final bool? fromLocal;

  const ApiResponseStatus({
    this.data,
    this.error,
    required this.isSuccessful,
    this.fromLocal,
  });
}
