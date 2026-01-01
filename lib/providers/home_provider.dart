import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/business.dart';
import '../models/category.dart';
import '../repositories/home_repository.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepository repository = HomeRepository();

  List<Category> categories = [];
  List<Product> products = [];
  Business? business; // nullable to start

  String selectedCategory = "All";
  String searchQuery = "";
  bool loading = true; // start as loading

  HomeProvider() {
    init(); // load data immediately
  }

  Future<void> init() async {
    await fetchHomeData();
  }

  Future<void> fetchHomeData({String? category, String? search}) async {
    loading = true;
    notifyListeners();

    try {
      final data = await repository.fetchHome(
        category: category,
        search: search,
      );

      categories = (data['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList();

      products = (data['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList();

      business = Business.fromJson(data['business']);
    } catch (e) {
      debugPrint("Fetch home data error: $e");
    }

    loading = false;
    notifyListeners();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    fetchHomeData(category: category, search: searchQuery);
  }

  void search(String query) {
    searchQuery = query;
    fetchHomeData(category: selectedCategory, search: query);
  }
}
