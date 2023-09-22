
class CustomResponse<T> {
  String? message;
  int? status;
  T? data;

  CustomResponse({required this.message, required this.status, required this.data});

  factory CustomResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return CustomResponse<T>(
      message: json['message'] as String,
      status: json['status'] as int,
      data: json["data"] != null ? fromJsonT(json['data']) : null
    );
  }

  Map<String, dynamic> toJson(dynamic Function(T) toJsonT) {
    return toJsonT(data as T);
  }
}