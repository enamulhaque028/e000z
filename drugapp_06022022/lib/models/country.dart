class Country {
  final String productName;
  final String productNo;
  final String genericName;
  final String thumbLink;
  final int count;
  final int id;

  final int productId;
  final String productDescription;
  final String parentProductNo;
  final String productUnitOfMeasurmentNo;
  final String productUnitOfMeasurmentName;
  final String genericNo;
  final String productStrength;
  final int strengthUnitId;
  final int productTotalStrength;
  final String productTypeNo;
  final String productTypeName;
  final String productCatagoryNo;
  final String productCatagoryName;
  final int showProductNewFlag;
  final String productFlag;
  final String userDefineProductNo;
  final int recordShowFlag;
  final int activeStatusFlag;
  final String rowLanguageCode;
  final String categoryType;
  final double unitPrice;

  Country({
    this.id,
    this.count,
    this.productName,
    this.genericName,
    this.thumbLink,
    this.productId,
    this.productNo,
    this.productDescription,
    this.parentProductNo,
    this.productUnitOfMeasurmentNo,
    this.productUnitOfMeasurmentName,
    this.genericNo,
    this.productStrength,
    this.strengthUnitId,
    this.productTotalStrength,
    this.productTypeNo,
    this.productTypeName,
    this.productCatagoryNo,
    this.productCatagoryName,
    this.showProductNewFlag,
    this.productFlag,
    this.userDefineProductNo,
    this.recordShowFlag,
    this.activeStatusFlag,
    this.rowLanguageCode,
    this.categoryType,
    this.unitPrice,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      productName: json["productName"],
      productNo: json["productNo"],
      genericName: json["genericName"],
      thumbLink: json["thumbLink"],
      productId: json["productId"],
      productDescription: json["productDescription"],
      parentProductNo: json["parentProductNo"],
      productUnitOfMeasurmentNo: json["productUnitOfMeasurmentNo"],
      productUnitOfMeasurmentName: json["productUnitOfMeasurmentName"],
      genericNo: json["genericNo"],
      productStrength: json["productStrength"],
      strengthUnitId: json["strengthUnitId"],
      productTotalStrength: json["productTotalStrength"],
      productTypeNo: json["productTypeNo"],
      productTypeName: json["productTypeName"],
      productCatagoryNo: json["productCatagoryNo"],
      productCatagoryName: json["productCatagoryName"],
      showProductNewFlag: json["showProductNewFlag"],
      productFlag: json["productFlag"],
      userDefineProductNo: json["userDefineProductNo"],
      recordShowFlag: json["recordShowFlag"],
      activeStatusFlag: json["activeStatusFlag"],
      rowLanguageCode: json["rowLanguageCode"],
      categoryType: json["categoryType"],
      unitPrice: json["unitPrice"] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productNo": productNo,
        "genericName": genericName,
        "thumbLink": thumbLink,
        "productId": productId,
        "productDescription": productDescription,
        "parentProductNo": parentProductNo,
        "productUnitOfMeasurmentNo": productUnitOfMeasurmentNo,
        "productUnitOfMeasurmentName": productUnitOfMeasurmentName,
        "genericNo": genericNo,
        "productStrength": productStrength,
        "strengthUnitId": strengthUnitId,
        "productTotalStrength": productTotalStrength,
        "productTypeNo": productTypeNo,
        "productTypeName": productTypeName,
        "productCatagoryNo": productCatagoryNo,
        "productCatagoryName": productCatagoryName,
        "showProductNewFlag": showProductNewFlag,
        "productFlag": productFlag,
        "userDefineProductNo": userDefineProductNo,
        "recordShowFlag": recordShowFlag,
        "activeStatusFlag": activeStatusFlag,
        "rowLanguageCode": rowLanguageCode,
        "categoryType": categoryType,
        "unitPrice": unitPrice,
      };

  factory Country.fromDb(Map<String, dynamic> json) {
    return Country(
      id: json["id"],
      productName: json["productName"],
      productNo: json["productNo"],
      count: json["count"],
      thumbLink: json["thumbLink"],
      genericName: json["genericName"],
    );
  }
}

/*-----------------------------------Employee Table Info-----------------------------------*/
class AddToCart {
  String productName;
  String thumbLink;
  String productAmount;

  AddToCart({this.productName, this.productAmount, this.thumbLink});

  AddToCart.fromMap(Map<String, dynamic> map) {
    productName = map['productName'];
    thumbLink = map['thumbLink'];
    productAmount = map['productAmount'];
  }
}

/*-----------------------------------Cart Table Model-----------------------------------*/

class AddToCartTable {
  String productNo;
  String productName;
  String genericName;
  String thumbLink;
  String productAmount;
  String unitPrice;
  double totalPrice;
  String isPending;

  AddToCartTable({
    this.productNo,
    this.productName,
    this.genericName,
    this.thumbLink,
    this.productAmount,
    this.unitPrice,
    this.totalPrice,
    this.isPending,
  });

  AddToCartTable.fromMap(Map<String, dynamic> map) {
    productNo = map['productNo'];
    productName = map['productName'];
    genericName = map['genericName'];
    thumbLink = map['thumbLink'];
    productAmount = map['productAmount'];
    unitPrice = map['unitPrice'];
    totalPrice = map['totalPrice'];
    isPending = map['isPending'];
  }
}

/*-----------------------------------Favourite Table Model-----------------------------------*/

class AddToFavourite {
  String productNo;
  String productName;
  String genericName;
  String thumbLink;

  AddToFavourite({
    this.productNo,
    this.productName,
    this.genericName,
    this.thumbLink,
  });

  AddToFavourite.fromMap(Map<String, dynamic> map) {
    productNo = map['productNo'];
    productName = map['productName'];
    genericName = map['genericName'];
    thumbLink = map['thumbLink'];
  }
}

/*-----------------------------------ShortList Table Model-----------------------------------*/

class AddToShortList {
  String productNo;
  String productName;
  String genericName;
  String thumbLink;

  AddToShortList({
    this.productNo,
    this.productName,
    this.genericName,
    this.thumbLink,
  });

  AddToShortList.fromMap(Map<String, dynamic> map) {
    productNo = map['productNo'];
    productName = map['productName'];
    genericName = map['genericName'];
    thumbLink = map['thumbLink'];
  }
}

/*-----------------------------------Search History Table Model-----------------------------------*/

class SearchHistory {
  int id;
  String productName;
  String productCategory;

  SearchHistory({
    this.id,
    this.productName,
    this.productCategory,
  });

  SearchHistory.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    productName = map['productName'];
    productCategory = map['productCategory'];
  }
}

/*-----------------------------------User ClickEvent Model-----------------------------------*/

class ClickEvent {
  int id;
  String userActivity;
  String page;
  String date;

  ClickEvent({
    this.id,
    this.userActivity,
    this.page,
    this.date,
  });

  ClickEvent.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userActivity = map['userActivity'];
    page = map['page'];
    date = map['date'];
  }
}
