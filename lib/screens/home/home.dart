import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ===== Bottom Navigation =====
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Wishlist"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Transaction"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Header =====
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.store, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Luxeshop",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined)),
                ],
              ),

              const SizedBox(height: 16),

              // ===== Search =====
              TextField(
                decoration: InputDecoration(
                  hintText: "Find what you need...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.tune),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== Categories =====
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CategoryItem(icon: Icons.devices, title: "Electronic"),
                  SizedBox(width: 10),
                  CategoryItem(icon: Icons.watch, title: "Accessories"),
                  SizedBox(width: 10),
                  CategoryItem(icon: Icons.checkroom, title: "Fashion"),
                ],
              ),

              const SizedBox(height: 28),

              // ===== Flash Sale Banner =====
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black,
                ),
                child: Stack(
                  children: [
                    // Image on right
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        child: Image.asset(
                          "assets/images/flash_sale.png",
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Text + Button
                    Positioned(
                      left: 16,
                      top: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "6.6 Flash Sale",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Cashback Up to 100%",
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                            onPressed: () {},
                            child: const Text("Shop Now"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ===== Products Vertically =====
              Column(
                children: const [
                  ProductCard(
                    name: "iPad Pro 6th Gen",
                    discount: "6% off",
                    imagePath: "assets/images/ipad.png",
                  ),
                  SizedBox(height: 16),
                  ProductCard(
                    name: "Macbook Air M2",
                    discount: "10% off",
                    imagePath: "assets/images/macbook.png",
                  ),
                  SizedBox(height: 16),
                  ProductCard(
                    name: "iPhone 15 Pro",
                    discount: "15% off",
                    imagePath: "assets/images/iphone.png",
                  ),
                  SizedBox(height: 16),
                  ProductCard(
                    name: "Apple Watch",
                    discount: "20% off",
                    imagePath: "assets/images/watch.png",
                  ),
                  SizedBox(height: 16),
                  ProductCard(
                    name: "AirPods Pro",
                    discount: "5% off",
                    imagePath: "assets/images/airpods.png",
                  ),
                  SizedBox(height: 16),
                  ProductCard(
                    name: "Mac Mini",
                    discount: "12% off",
                    imagePath: "assets/images/macmini.png",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= Category Item =================
class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFF5F5F5),
          child: Icon(icon, color: Colors.orange),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// ================= Product Card =================
class ProductCard extends StatelessWidget {
  final String name;
  final String discount;
  final String imagePath;

  const ProductCard({
    required this.name,
    required this.discount,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(discount, style: const TextStyle(color: Colors.orange)),
                const SizedBox(height: 4),
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
