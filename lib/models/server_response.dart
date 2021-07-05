class ServerResponse {
  bool? status;
  String? message;
  String? token;
  String? type;
  List<ValidationError>? errors;

  ServerResponse({
    this.message,
    this.status,
    this.token,
    this.type,
    this.errors,
  });

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    final List<ValidationError> errors = [];
    if (json['errors'] != null)
      json['errors']
          .map(
            (error) => errors.add(
              ValidationError(
                value: error['value'].toString(),
                msg: error['msg'].toString(),
                param: error['param'].toString(),
                location: error['location'].toString(),
              ),
            ),
          )
          .toList();

    return ServerResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      token: json['token'] as String?,
      type: json['type'] as String?,
      errors: errors,
    );
  }
}

class ValidationError {
  String? value;
  String? msg;
  String? param;
  String? location;

  ValidationError({this.location, this.msg, this.param, this.value});
}
