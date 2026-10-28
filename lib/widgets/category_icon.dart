import 'package:flutter/material.dart';

class CategoryItem {
  final String label;
  final IconData icon;
  final Color color;
  const CategoryItem(this.label, this.icon, this.color);
}

const CategoryItem catBaru = CategoryItem('Produk\nTerbaru', Icons.fiber_new, Colors.amber);
const CategoryItem catBeliLagi = CategoryItem('Beli Lagi', Icons.history, Colors.redAccent);
const CategoryItem catClearance = CategoryItem('Clearance\nSale', Icons.timer_outlined, Colors.black87);
const CategoryItem catSayur = CategoryItem('Sayur', Icons.eco, Colors.green);
const CategoryItem catBuah = CategoryItem('Buah', Icons.local_grocery_store, Colors.orange);
const CategoryItem catProtein = CategoryItem('Protein', Icons.set_meal, Colors.deepOrange);

/// Ikon kategori bulat + label. [selected] memberi kotak hijau (halaman Protein).
class CategoryIcon extends StatelessWidget {
  final CategoryItem item;
  final bool selected;
  final VoidCallback onTap;

  const CategoryIcon({
    super.key,
    required this.item,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 64,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
              color: selected ? Colors.green : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: item.color),
            ),
            const SizedBox(height: 4),
            Text(item.label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 9)),
          ],
        ),
      ),
    );
  }
}
