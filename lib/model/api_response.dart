class ApiResponse<T> {
  final String message;
  final bool status;
   List<T>? data;
  ApiResponse({
    required this.message,
    required this.status,
  });
  ApiResponse.list({
    required this.status,
    required this.message,
    required this.data,
});
}
