class DeliverOrderModal {
  DeliverOrderModal({
    required this.rowId,
    required this.storeId,
    required this.userId,
    required this.uniqueId,
    required this.delivery,
    required this.userPhone,
    required this.productCount,
    required this.address,
    required this.userLat,
    required this.userLong,
  });

  String rowId;
  String storeId;
  String userId;
  String uniqueId;
  String delivery;
  String userPhone;
  String productCount;
  String address;
  String userLat;
  String userLong;

  factory DeliverOrderModal.fromJson(Map<String, dynamic> json) =>
      DeliverOrderModal(
        rowId: json["row_id"],
        storeId: json["store_id"],
        userId: json["user_id"],
        uniqueId: json["unique_id"],
        delivery: json["delivery"],
        userPhone: json["user_phone"],
        productCount: json["product_count"],
        address: json["address"],
        userLat: json["user_lat"],
        userLong: json["user_long"],
      );

  Map<String, dynamic> toJson() => {
        "row_id": rowId,
        "store_id": storeId,
        "user_id": userId,
        "unique_id": uniqueId,
        "delivery": delivery,
        "user_phone": userPhone,
        "product_count": productCount,
        "address": address,
        "user_lat": userLat,
        "user_long": userLong,
      };
}
