import 'package:flutter/material.dart';

class CustomNavigationBarItem extends StatelessWidget {
   CustomNavigationBarItem(
      {super.key,
      required this.isSelected,
      required this.icon,
      required this.onTap,
      required this.colors,required this.items});
  final bool isSelected;
  final Widget icon;
  final void Function(int)? onTap;
  final Color? colors;
   List<BottomNavigationBarItem> items;  

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      onTap: onTap,
      );
  }
}
