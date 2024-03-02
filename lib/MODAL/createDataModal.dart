class CreateUserModal {
  CreateUserModal({
    required this.success,
    required this.message,
  });

  String success;
  String message;

  factory CreateUserModal.fromJson(Map<String, dynamic> json) =>
      CreateUserModal(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
