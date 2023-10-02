import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/rounded_tap_button.dart';

const List<String> tabItems = ["Піцци", "Салати", "Супи", "Напої"];

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({
    super.key,
  });

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  late String currentCategory = tabItems[0];

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: tabItems
                .map(
                  (tabItemName) => RPadding(
                    padding: const EdgeInsets.only(right: 3),
                    child: RoundedTabButton(
                      isActive: currentCategory == tabItemName,
                      text: tabItemName,
                      onTap: () {
                        setState(() {
                          currentCategory = tabItemName;
                        });
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class CategoryTabsItem extends StatelessWidget {
  const CategoryTabsItem({
    super.key,
    required this.isActive,
    required this.categoryName,
    required this.tapped,
  });

  final String categoryName;
  final bool isActive;
  final Function() tapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapped,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive ? Theme.of(context).primaryColor : null,
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1.5,
          ),
        ),
        duration: const Duration(milliseconds: 200),
        child: Text(
          categoryName,
          style: TextStyle(
            color: isActive ? Colors.white : Theme.of(context).primaryColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
