import 'package:flutter/material.dart';
import 'package:ui_drawer_translation/constants.dart';
import 'package:ui_drawer_translation/models/category.dart';
import 'package:ui_drawer_translation/provider/category_provider.dart';

import 'home_screen_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  bool isScaled = false;

  @override
  void initState() {
    _resetValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: !isScaled
            ? null
            : () {
                setState(() {
                  _resetValues();
                  isScaled = false;
                });
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: !isScaled ? null : BorderRadius.circular(30),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              HomeScreenAppBar(
                isScaled: isScaled,
                onNotScaled: _onNotScaled,
                onScaled: _onScaled,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.pageBackground,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: const [
                      _SearchBox(),
                      _CategoryList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onScaled() {
    setState(() {
      _resetValues();
      isScaled = false;
    });
  }

  _onNotScaled() {
    setState(() {
      _setValues();
      isScaled = true;
    });
  }

  _resetValues() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
  }

  _setValues() {
    xOffset = 0.35 * MediaQuery.of(context).size.height;
    yOffset = 0.2 * MediaQuery.of(context).size.width;
    scaleFactor = 0.7;
  }
}

class _CategoryList extends StatefulWidget {
  const _CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  State<_CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<_CategoryList> {
  late final List<Category> categoryList;
  String selectedCategory = 'Cats';

  @override
  void initState() {
    var categoryProvider = CategoryProvider()..fetchData();
    categoryList = categoryProvider.getCategories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var category = categoryList[index];
          return _CategoryIcon(
              category: category,
              isSelected: category.title == selectedCategory,
              onSelect: (value) {
                setState(() {
                  selectedCategory = value;
                });
              });
        },
        itemCount: categoryList.length,
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final bool isSelected;
  final Function(String value) onSelect;
  const _CategoryIcon({
    Key? key,
    required this.category,
    required this.onSelect,
    this.isSelected = false,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    var margin = const EdgeInsets.only(left: 25);
    var padding = const EdgeInsets.symmetric(horizontal: 5);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColor.backgroundColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: margin,
          padding: padding,
          child: IconButton(
            onPressed: () => onSelect(category.title),
            icon: Image.asset(
              category.icon,
              color: isSelected ? Colors.white : AppColor.disableFontColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: margin,
          child: Text(category.title),
        ),
      ],
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.search_rounded),
          SizedBox(width: 10),
          Expanded(child: Text('Search pet to adopt')),
          Icon(Icons.tune_rounded),
        ],
      ),
    );
  }
}
