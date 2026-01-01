class Product {
  final String name;
  final double price;
  final String? image_url;
  final Discount? discount;

  Product({
    required this.name,
    required this.price,
    this.image_url,
    this.discount,
  });

  double get finalPrice {
    if (discount == null) return price;

    if (discount!.isPercentage) {
      return price - (price * discount!.value / 100);
    } else {
      return price - discount!.value;
    }
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image_url: json['image_url'],
      discount: json['discount'] != null
          ? Discount.fromJson(json['discount'])
          : null,
    );
  }
}

class Discount {
  final int id;
  final double value;
  final bool isPercentage;

  Discount({required this.id, required this.value, required this.isPercentage});

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      id: json['id'],
      value: double.tryParse(json['value']?.toString() ?? '0') ?? 0,
      isPercentage: json['is_percentage'] == 1 || json['is_percentage'] == true,
    );
  }
}
