import 'package:flutter/material.dart';

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
    return GestureDetector(
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
          borderRadius: !isScaled ? null : BorderRadiusDirectional.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  isScaled
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _resetValues();
                              isScaled = false;
                            });
                          },
                          icon: const Icon(Icons.arrow_back),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _setValues();
                              isScaled = true;
                            });
                          },
                          icon: const Icon(Icons.menu),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
