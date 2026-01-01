import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String discount;
  final double price;
  final String image;
  final VoidCallback? onAdd; // 👈 Add callback

  const ProductCard({
    super.key,
    required this.name,
    required this.discount,
    required this.price,
    required this.image,
    this.onAdd, // optional
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // keep your original card height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE AREA (FLEXIBLE, FULL WIDTH)
          Expanded(
            child: Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  image,
                  fit: BoxFit.contain, // keep your original image behavior
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            discount,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // Row with price + Add icon (only addition)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$$price",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
