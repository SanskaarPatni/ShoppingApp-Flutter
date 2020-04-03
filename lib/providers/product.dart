import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {@required this.description,
      @required this.id,
      @required this.imageUrl,
      this.isFavourite = false,
      
      @required this.price,
      @required this.title});

  Future<void> toggleFavouriteStatus(String token,String userId) async {
    final oldStatus = isFavourite;
  final url =
        'https://dec2019shopappproject.firebaseio.com//userFavourites/$userId/$id.json?auth=$token';
    isFavourite = !isFavourite;
    notifyListeners();

    try {
      final response=await http.put(url,
          body: json.encode({
            'isFavourite': isFavourite,
          }));
          //trycatch only works for get 
          //patch,put,delete ke liye..
          if(response.statusCode>=400){
            isFavourite = oldStatus;
      notifyListeners();

          }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
