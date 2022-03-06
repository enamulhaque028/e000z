import 'package:http/http.dart' as http;
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/models/product_des.dart';
import 'package:mediinfo/models/token.dart';

Future getProductInfo(String productNo) async {
  String token = await Token().getToken();
  String tokenType = await Token().getTokenType();
  // print('Token: $token');
  // print('Token Type: $tokenType');

  String extUrl = 'product/find/$productNo';
  String url = baseUrl + extUrl;
  //String url = "http://192.168.0.91:8085/product-api/product/find/$productNo";
  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$tokenType $token',
    },
  );
  if (response.statusCode == 200) {
    //print(response.body);
    return productFromJson(response.body);
  } else {
    throw Exception("Unable to perform request!");
  }
}
