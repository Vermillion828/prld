import 'package:flutter/material.dart';
import 'package:honda_prelude/screen_data.dart';
import 'package:honda_prelude/screens/home/home.dart';
import 'package:honda_prelude/screens/splash/splash.dart';
import 'package:honda_prelude/utils/generation.dart';
import 'package:honda_prelude/utils/navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Honda Prelude',
      onGenerateRoute: handleNavigation,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: getSavedCurrentGeneration(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider(
              create: (context) => ScreenData(generation: snapshot.data as int),
              child: const HomePage(),
            );
          } else {
            return const Splash();
          }
        },
      ),
    );
  }
}
