class CartistCredentials {
  CartistCredentials({
    required this.success,
    required this.message,
    required this.appData,
  });

  String success;
  String message;
  AppData appData;

  factory CartistCredentials.fromJson(Map<String, dynamic> json) =>
      CartistCredentials(
        success: json["success"],
        message: json["message"],
        appData: AppData.fromJson(json["app data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "app data": appData.toJson(),
      };
}

class AppData {
  AppData({
    required this.id,
    required this.version,
    required this.appId,
    required this.data,
    required this.mVersion,
  });

  String id;
  String version;
  String appId;
  String data;
  String mVersion;

  factory AppData.fromJson(Map<String, dynamic> json) => AppData(
        id: json["id"],
        version: json["version"],
        appId: json["app_id"],
        data: json["data"],
        mVersion: json["m_version"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "app_id": appId,
        "data": data,
        "m_version": mVersion,
      };
}
