import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../providers/home_provider.dart';
import './../../widgets/product_card.dart';
import './../../widgets/category_chip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          // show full-page loader until all data is ready
          if (provider.loading || provider.business == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // everything is ready
          return Scaffold(
            backgroundColor: const Color(0xFFF4F5F7),
            appBar: AppBar(
              elevation: 0, 
              backgroundColor: Colors.white,
              title: Text(
                provider.business!.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: const [
                Icon(Icons.search, color: Colors.black),
                SizedBox(width: 16),
                Icon(Icons.shopping_bag_outlined, color: Colors.black),
                SizedBox(width: 16),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: "Wishlist",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long),
                  label: "Orders",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: "Profile",
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _searchBar(provider),
                const SizedBox(height: 12),
                _categoryRow(provider),
                const SizedBox(height: 16),
                _flashSale(provider),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final p = provider.products[index];
                      return ProductCard(
                        name: p.name,
                        discount: p.discount != null
                            ? p.discount!.isPercentage
                                  ? "${p.discount!.value}% OFF"
                                  : "\$${p.discount!.value} OFF"
                            : "No Discount",
                        price: p.price,
                        image: p.image_url!,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _searchBar(HomeProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: provider.search,
        decoration: InputDecoration(
          hintText: "Search products",
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _categoryRow(HomeProvider provider) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: provider.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final category = provider.categories[i].name;
          final isSelected = category == provider.selectedCategory;
          return CategoryChip(
            name: category,
            selected: isSelected,
            onTap: () => provider.selectCategory(category),
          );
        },
      ),
    );
  }

  Widget _flashSale(HomeProvider provider) {
    const flashTitle = "Flash Sale";
    const flashSubtitle = "Up to 20% OFF";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                "$flashTitle\n$flashSubtitle",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
