class ApiReturnUsers<T> {
  T? value;
  String? message;
  late String code;

  ApiReturnUsers({
    this.value,
    required this.code,
    this.message,
  });
}
