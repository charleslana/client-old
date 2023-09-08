import 'dart:convert';

class HandleError {
  HandleError({
    required this.message,
    this.errors,
  });

  factory HandleError.fromMap(Map<String, dynamic> map) {
    return HandleError(
      message: map['message'] as String,
      errors: map['errors'] != null ? List<String>.from(map['errors']) : null,
    );
  }

  factory HandleError.fromJson(String source) =>
      HandleError.fromMap(json.decode(source) as Map<String, dynamic>);

  final String message;
  final List<String>? errors;

  HandleError copyWith({
    String? message,
    List<String>? errors,
  }) {
    return HandleError(
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'errors': errors,
    };
  }

  String toJson() => json.encode(toMap());
}
