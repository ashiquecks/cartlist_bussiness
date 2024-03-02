class OrderModal {
  OrderModal({
    required this.orderId,
    required this.userId,
    required this.storeId,
    required this.productCount,
    required this.userLat,
    required this.userLong,
    required this.userPhone,
    required this.userHouse,
    required this.landmark,
    required this.place,
    required this.city,
    required this.pinCode,
    required this.uniqueId,
    required this.purchaseDate,
    required this.distance,
    required this.delivery,
  });

  String orderId;
  String userId;
  String storeId;
  String productCount;
  String userLat;
  String userLong;
  String userPhone;
  String userHouse;
  String landmark;
  String place;
  String city;
  String pinCode;
  String uniqueId;
  String purchaseDate;
  String distance;
  String delivery;

  factory OrderModal.fromJson(Map<String, dynamic> json) => OrderModal(
        orderId: json["order_id"],
        userId: json["user_id"],
        storeId: json["store_id"],
        productCount: json["product_count"],
        userLat: json["user_lat"],
        userLong: json["user_long"],
        userPhone: json["user_phone"],
        userHouse: json["user_house"],
        landmark: json["landmark"],
        place: json["place"],
        city: json["city"],
        pinCode: json["pin_code"],
        uniqueId: json["unique_id"],
        purchaseDate: json["purchase_date"],
        distance: json["distance"],
        delivery: json["delivery"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "store_id": storeId,
        "product_count": productCount,
        "user_lat": userLat,
        "user_long": userLong,
        "user_phone": userPhone,
        "user_house": userHouse,
        "landmark": landmark,
        "place": place,
        "city": city,
        "pin_code": pinCode,
        "unique_id": uniqueId,
        "purchase_date": purchaseDate,
        "distance": distance,
        "delivery": delivery,
      };
}
