class SuccessResponse<T> {
  final bool status;
  final String message;
  final String? token;
  final T data;

  SuccessResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.data,
  });

  factory SuccessResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT, {
    String? keyName,
  }) {
    final dataJson = json[keyName ?? "data"];

    return SuccessResponse<T>(
      status: json["success"] ?? false,
      message: json["message"] ?? "",
      token: json["token"] ?? "",
      data: fromJsonT(dataJson),
    );
  }
}
