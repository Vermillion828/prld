import 'package:flutter/material.dart';

void welcomeAnimation(PageController pageController) {
  const offset = 50.0;
  final currentPage = (pageController.page ?? 0.0).toInt();
  var steps = [];
  if (currentPage == 0) {
    steps = [
      pageController.offset + offset,
    ];
  } else if (currentPage == 4) {
    steps = [
      pageController.offset - offset,
    ];
  } else {
    steps = [
      pageController.offset + offset,
      pageController.offset - offset,
    ];
  }
  final shakePagesStream = Stream<int>.periodic(
    const Duration(
      milliseconds: 750,
    ),
    (gen) => gen,
  ).take(steps.length);
  shakePagesStream.forEach((element) {
    pageController.animateTo(
      steps[element],
      duration: const Duration(
        milliseconds: 200,
      ),
      curve: Curves.fastOutSlowIn,
    );
  });
}
