import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String productName;
  String productDescription;
  double unitPrice;
  List<String> productImageDownloadUrl;

  Product({
    this.productName,
    this.productDescription,
    this.productImageDownloadUrl,
    this.unitPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productName: json["productName"],
        productDescription: json["productDescription"],
        unitPrice: json["unitPrice"] ?? 1,
        productImageDownloadUrl: json["productImageGetUrl"] != null
            ? List<String>.from(json["productImageGetUrl"].map((x) => x))
            // ignore: deprecated_member_use
            : List<String>(),
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productDescription": productDescription,
        "unitPrice": unitPrice,
        "productImageGetUrl":
            List<dynamic>.from(productImageDownloadUrl.map((x) => x)),
      };
}
