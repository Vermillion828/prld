import 'package:flutter/material.dart';

bool getIsSmallScreen(BuildContext context) =>
    MediaQuery.of(context).size.height < 620;
