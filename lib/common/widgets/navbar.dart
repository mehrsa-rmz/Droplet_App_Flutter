import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application/features/explore/screens/explore.dart';
import 'package:flutter_application/features/products/screens/favorites.dart';
import 'package:flutter_application/features/order/screens/shopping_cart.dart';
import 'package:flutter_application/features/products/screens/product_categories.dart';
import 'package:flutter_application/features/profile/screens/profile.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:get/get.dart';

// Custome widget for bottom bar

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.selectedOption});

  final String selectedOption;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      clipBehavior: Clip.antiAlias,
      color: blue7,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x59223944),
              spreadRadius: 0,
              blurRadius: 30,
              offset: Offset(0, -8),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBottomBar(
                  text: "Explore",
                  icon: CupertinoIcons.compass,
                  selected: widget.selectedOption == 'explore',
                  onPressed: () => Get.to(() => const ExploreScreen())),
              IconBottomBar(
                  text: "Products",
                  icon: CupertinoIcons.square_grid_2x2,
                  selected: widget.selectedOption == 'products',
                  onPressed: () => Get.to(() => const ProductCategoriesScreen())),
              IconBottomBar(
                  text: "Profile",
                  icon: CupertinoIcons.person,
                  selected: widget.selectedOption == 'profile',
                  onPressed: () => Get.to(() => const ProfileScreen())),
              IconBottomBarWithBadge(
                  text: "Favorites",
                  number: 2, // TODO
                  icon: CupertinoIcons.heart,
                  selected: widget.selectedOption == 'favorites',
                  onPressed: () => Get.to(() => const FavoritesScreen())),
              IconBottomBarWithBadge(
                  text: "Cart",
                  number: 2, // TODO
                  icon: CupertinoIcons.cart,
                  selected: widget.selectedOption == 'cart',
                  onPressed: () => Get.to(() => const ShoppingCartScreen())),
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {super.key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed});
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: selected
          ? BoxDecoration(
              border: Border(bottom: BorderSide(color: pink5, width: 2)))
          : null,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 32, color: selected ? pink5 : white1),
      ),
    );
  }
}

class IconBottomBarWithBadge extends StatelessWidget {
  const IconBottomBarWithBadge(
      {super.key,
      required this.text,
      required this.number,
      required this.icon,
      required this.selected,
      required this.onPressed});
  final String text;
  final int number;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: selected
          ? BoxDecoration(
              border: Border(bottom: BorderSide(color: pink5, width: 2)))
          : null,
      child: IconButton(
        onPressed: onPressed,
        icon: number > 0
            ? Badge(
                label: Text(number.toString()),
                child: Icon(icon, color: selected ? pink5 : white1, size: 32),
              )
            : Icon(icon, size: 32, color: selected ? pink5 : white1),
      ),
    );
  }
}
