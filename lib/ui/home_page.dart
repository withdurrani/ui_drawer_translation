import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Theme.of(context).primaryColor),
          const HomeScreen(),
        ],
      ),
    );
  }
}

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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      color: Colors.white,
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
    );
  }

  _resetValues() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
  }

  _setValues() {
    xOffset = 0.25 * MediaQuery.of(context).size.height;
    yOffset = 0.25 * MediaQuery.of(context).size.width;
    scaleFactor = 0.6;
  }
}
