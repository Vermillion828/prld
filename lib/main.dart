import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honda_prelude/screen_data.dart';
import 'package:honda_prelude/screens/mopowababeh/mo_powa_babeh.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  Future<int> _getSavedCurrentGeneration() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    return prefs.getInt('GENERATION') ?? 5;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Honda Prelude',
      onGenerateRoute: (settings) {
        if (settings.name == MoPowaBabeh.routeName) {
          return MaterialPageRoute(
            builder: (context) => const MoPowaBabeh(),
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _getSavedCurrentGeneration(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider(
              create: (context) => ScreenData(generation: snapshot.data as int),
              child: const HomePage(),
            );
          } else {
            return Material(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    'PRLD',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 60.0,
                    ),
                  ),
                  Platform.isIOS
                      ? const CupertinoActivityIndicator()
                      : const CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.height < 620;
    PageController pageController = PageController(
        initialPage: context.watch<ScreenData>().getGeneration() - 1);

    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.black,
                foregroundColor: Colors.red,
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: orientation == Orientation.portrait
                    ? (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).padding.top)
                    : (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.bottom),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  centerTitle: true,
                  title: GestureDetector(
                    onPanUpdate: (details) {
                      if (details.delta.dx > 0 &&
                          (pageController.page ?? 0.0) > 0.0) {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                      if (details.delta.dx < 0 &&
                          (pageController.page ?? 4.0) < 4.0) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: _getGradientColors(),
                          stops: _getGradientStops(),
                        ),
                      ),
                      child: Consumer<ScreenData>(
                        builder: (context, screenData, child) => Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ..._getLeftDots(screenData.getGeneration()),
                                Text(
                                  'Prelude ${screenData.getGeneration()} gen',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                                ..._getRightDots(screenData.getGeneration()),
                              ],
                            ),
                            Text(
                              '(${_getYears(screenData.getGeneration())})',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w300,
                                fontSize: 10.0,
                              ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  background: PageView(
                    controller: pageController,
                    onPageChanged: (value) {
                      context.read<ScreenData>().setGeneration(value + 1);
                      _saveCurrentGeneration(value + 1);
                    },
                    children: _getPages(),
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Material(
                    color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                    child: Center(
                      child: isSmallScreen
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: 'more_power_btn_$index',
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      MoPowaBabeh.routeName,
                                      // arguments: screenData,
                                    );
                                  },
                                  tooltip: 'More power!',
                                  child: const Icon(Icons.car_repair),
                                ),
                                const SizedBox(height: 8.0),
                                const Text(
                                  'MORE POWER!',
                                  style: TextStyle(fontSize: 11.0),
                                ),
                              ],
                            )
                          : FloatingActionButton.large(
                              heroTag: 'more_power_btn_$index',
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  MoPowaBabeh.routeName,
                                  // arguments: screenData,
                                );
                              },
                              tooltip: 'More power!',
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(Icons.car_repair),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'MORE',
                                    style: TextStyle(fontSize: 11.0),
                                  ),
                                  Text(
                                    'POWER!',
                                    style: TextStyle(fontSize: 11.0),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveCurrentGeneration(int currentGeneration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('GENERATION', currentGeneration);
  }

  List<Widget> _getLeftDots(int curentGen) {
    List<Widget> dots = [];
    for (int i = 5; i > 0; i--) {
      dots.add(
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: i < curentGen ? 1.0 : 0.0,
          child: const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(
              Icons.circle,
              color: Colors.white70,
              size: 4.0,
            ),
          ),
        ),
      );
      dots.add(const SizedBox(
        width: 4.0,
      ));
    }
    return dots;
  }

  List<Widget> _getRightDots(int curentGen) {
    List<Widget> dots = [];
    for (int i = 5; i > 0; i--) {
      dots.add(const SizedBox(
        width: 4.0,
      ));
      dots.add(
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: curentGen < i ? 1.0 : 0.0,
          child: const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(
              Icons.circle,
              color: Colors.white70,
              size: 4.0,
            ),
          ),
        ),
      );
    }
    return dots;
  }

  List<Color> _getGradientColors() {
    return [
      Colors.transparent,
      Colors.black.withOpacity(0.1),
      Colors.black.withOpacity(0.2),
      Colors.black.withOpacity(0.3),
      Colors.black.withOpacity(0.4),
      Colors.black.withOpacity(0.5),
      Colors.black.withOpacity(0.6),
      Colors.black.withOpacity(0.7),
      Colors.black.withOpacity(0.8),
      Colors.black.withOpacity(0.9),
      Colors.black,
    ];
  }

  List<double> _getGradientStops() {
    return [
      0.0,
      0.1,
      0.2,
      0.3,
      0.4,
      0.5,
      0.6,
      0.7,
      0.8,
      0.9,
      1.0,
    ];
  }

  String _getYears(int generation) {
    switch (generation) {
      case 1:
        return '1978–1982';
      case 2:
        return '1982–1987';
      case 3:
        return '1987–1991';
      case 4:
        return '1991–1996';
      case 5:
        return '1996–2001';
      default:
        return '';
    }
  }

  List<Widget> _getPages() {
    List<Widget> pages = [];
    for (int i = 1; i < 6; i++) {
      final imagePath = 'images/preludes/${i}gen/1.jpg';
      pages.add(
        Container(
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.6,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(imagePath),
                ),
              ),
              Image(
                image: AssetImage(imagePath),
              ),
            ],
          ),
        ),
      );
    }
    return pages;
  }
}
