import 'package:flutter/material.dart';
import 'package:honda_prelude/screen_data.dart';
import 'package:honda_prelude/screens/home/app_bar.dart';
import 'package:honda_prelude/screens/home/menu_grid.dart';
import 'package:honda_prelude/utils/animation.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      welcomeAnimation(pageController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pageController = PageController(
        initialPage: context.watch<ScreenData>().getGeneration() - 1);

    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              getAppBar(
                orientation: orientation,
                context: context,
                pageController: pageController,
              ),
              const MenuGrid(),
            ],
          ),
        );
      },
    );
  }
}
