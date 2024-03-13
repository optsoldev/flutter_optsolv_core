class ApiResult<T extends Object> {
  bool? failure;
  bool? success;
  T? data;
  List<String>? messages;
  int? total;
  int? page;
  int? pageSize;
}
