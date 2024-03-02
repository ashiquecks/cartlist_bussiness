// To parse this JSON data, do
//
//     final profileModal = profileModalFromJson(jsonString);

class ProfileModal {
  ProfileModal({
    required this.success,
    required this.data,
  });

  String success;
  Data data;

  factory ProfileModal.fromJson(Map<String, dynamic> json) => ProfileModal(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.storeId,
    required this.storeName,
    required this.storeType,
    required this.storePhone,
    required this.storeImage,
    required this.city,
    required this.description,
    required this.homeDelevery,
    required this.openTime,
    required this.closeTime,
    required this.leaveDays,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.searchRadius,
    required this.userMail,
    required this.password,
    required this.status,
  });

  String storeId;
  String storeName;
  String storeType;
  String storePhone;
  String storeImage;
  String city;
  String description;
  String homeDelevery;
  String openTime;
  String closeTime;
  String leaveDays;
  String latitude;
  String longitude;
  String location;
  String searchRadius;
  String userMail;
  String password;
  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        storeId: json["store_id"],
        storeName: json["store_name"],
        storeType: json["store_type"],
        storePhone: json["store_phone"],
        storeImage: json["store_image"],
        city: json["city"],
        description: json["description"],
        homeDelevery: json["home_delevery"],
        openTime: json["open_time"],
        closeTime: json["close_time"],
        leaveDays: json["leave_days"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        location: json["location"],
        searchRadius: json["search_radius"],
        userMail: json["user_mail"],
        password: json["password"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "store_name": storeName,
        "store_type": storeType,
        "store_phone": storePhone,
        "store_image": storeImage,
        "city": city,
        "description": description,
        "home_delevery": homeDelevery,
        "open_time": openTime,
        "close_time": closeTime,
        "leave_days": leaveDays,
        "latitude": latitude,
        "longitude": longitude,
        "location": location,
        "search_radius": searchRadius,
        "user_mail": userMail,
        "password": password,
        "status": status,
      };
}
