class ConfirmOrderModal {
  ConfirmOrderModal({
    required this.rowId,
    required this.storeId,
    required this.userId,
    required this.uniqueId,
    required this.productCount,
    required this.delivery,
    required this.distance,
    required this.address,
    required this.userLat,
    required this.userLong,
    required this.userPhone,
    required this.confiemId,
  });

  String rowId;
  String storeId;
  String userId;
  String uniqueId;
  String productCount;
  String delivery;
  String distance;
  String address;
  String userLat;
  String userLong;
  String userPhone;
  String confiemId;

  factory ConfirmOrderModal.fromJson(Map<String, dynamic> json) =>
      ConfirmOrderModal(
        rowId: json["row_id"],
        storeId: json["store_id"],
        userId: json["user_id"],
        uniqueId: json["unique_id"],
        productCount: json["product_count"],
        delivery: json["delivery"],
        distance: json["distance"],
        address: json["address"],
        userLat: json["user_lat"],
        userLong: json["user_long"],
        userPhone: json["user_phone"],
        confiemId: json["confiem_id"],
      );

  Map<String, dynamic> toJson() => {
        "row_id": rowId,
        "store_id": storeId,
        "user_id": userId,
        "unique_id": uniqueId,
        "product_count": productCount,
        "delivery": delivery,
        "distance": distance,
        "address": address,
        "user_lat": userLat,
        "user_long": userLong,
        "user_phone": userPhone,
        "confiem_id": confiemId,
      };
}
