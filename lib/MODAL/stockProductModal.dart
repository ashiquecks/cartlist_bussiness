class StockProductModal {
  StockProductModal({
    required this.stockId,
    required this.userId,
    required this.productName,
    required this.productBrand,
    required this.productImage,
    required this.productCategory,
    required this.subCategory,
    required this.quantity,
    required this.quantityCategory,
    required this.amzone,
    required this.flipkart,
    required this.purchasedate,
    required this.uniqueId,
    required this.verify,
    required this.confiemId,
    required this.orderId,
  });

  String stockId;
  String userId;
  String productName;
  String productBrand;
  String productImage;
  String productCategory;
  String subCategory;
  String quantity;
  String quantityCategory;
  String amzone;
  String flipkart;
  String purchasedate;
  String uniqueId;
  String verify;
  String confiemId;
  String orderId;

  factory StockProductModal.fromJson(Map<String, dynamic> json) =>
      StockProductModal(
        stockId: json["stock_id "],
        userId: json["user_id"],
        productName: json["product_name"],
        productBrand: json["product_brand"],
        productImage: json["product_image"],
        productCategory: json["product_category"],
        subCategory: json["sub_category"],
        quantity: json["quantity"],
        quantityCategory: json["quantity_category"],
        amzone: json["amzone"],
        flipkart: json["flipkart"],
        purchasedate: json["purchasedate"],
        uniqueId: json["unique_id"],
        verify: json["verify"],
        confiemId: json["confiem_id"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "stock_id ": stockId,
        "user_id": userId,
        "product_name": productName,
        "product_brand": productBrand,
        "product_image": productImage,
        "product_category": productCategory,
        "sub_category": subCategory,
        "quantity": quantity,
        "quantity_category": quantityCategory,
        "amzone": amzone,
        "flipkart": flipkart,
        "purchasedate": purchasedate,
        "unique_id": uniqueId,
        "verify": verify,
        "confiem_id": confiemId,
        "order_id": orderId,
      };
}
