import 'package:flutter/foundation.dart';
import 'package:wapar/model/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _allProducts = [];
}
