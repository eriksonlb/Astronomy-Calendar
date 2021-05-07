import 'package:flutter/material.dart';
import 'package:astronomy_calendar/pages/index.dart';
import 'package:astronomy_calendar/themes/color.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: primary),
      home: IndexPage(),
    ));
