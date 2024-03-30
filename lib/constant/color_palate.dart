import 'package:flutter/material.dart';

const Color background = Color(0xFF343434);
const Color textRed = Color(0xFFFF0000);
const Color textWhite = Color(0xFFFFFFFF);
const Color searchField = Color(0x3DFFFFFF);
const Color searchFieldText = Color(0xB3FFFFFF);
const Color matteBlack = Color(0xFF28282B);

final Gradient darkGradient = LinearGradient(
  colors: [matteBlack, Colors.grey[700]!],
  // Replace Colors.grey[900] with your desired end color
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

const List<Gradient> colorGradients = [
  LinearGradient(
    colors: [Colors.black, Colors.white],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  LinearGradient(
    colors: [Colors.black12, Colors.red],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  LinearGradient(
    colors: [Colors.black12, Colors.green],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  LinearGradient(
    colors: [Colors.black12, Colors.blue],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  LinearGradient(
    colors: [Colors.black12, Colors.black],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  LinearGradient(
    colors: [Colors.white12, Colors.white],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  LinearGradient(
    colors: [Colors.black12, Colors.yellow],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  LinearGradient(
    colors: [Colors.black12, Colors.teal],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  LinearGradient(
    colors: [Colors.black, Colors.purple],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  LinearGradient(
    colors: [Colors.black12, Colors.orange],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
  LinearGradient(
    colors: [Colors.black, Color(0xFFFF00FF)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  ),
];

const styleRB24 = TextStyle(
  //color: Color(0xffFFA500),
  color: textRed,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const styleRB20 = TextStyle(
  //color: Color(0xffFFA500),
  color: textRed,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const styleWB24 = TextStyle(
  color: textWhite,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const styleWB16 = TextStyle(
  color: textWhite,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const styleWB20 = TextStyle(
  color: textWhite,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
