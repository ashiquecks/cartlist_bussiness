class NetworkResponse<T> {
  bool? isSuccessful;
  T? data;
  String? message;
  int? responseCode;

  NetworkResponse(
    this.isSuccessful,
    this.data, {
    this.message,
    this.responseCode,
  });
}
