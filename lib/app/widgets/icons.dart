import 'package:flutter/material.dart';
import '../core/values/colors.dart';
import '../core/values/icons.dart';

List<Icon> getIcons() {
  return [
    const Icon(
      IconData(icPerson, fontFamily: 'MaterialIcons'),
      color: purple,
    ),
    const Icon(
      IconData(icWork, fontFamily: 'MaterialIcons'),
      color: pink,
    ),
    const Icon(
      IconData(icMovie, fontFamily: 'MaterialIcons'),
      color: green,
    ),
    const Icon(
      IconData(icSport, fontFamily: 'MaterialIcons'),
      color: yellow,
    ),
    const Icon(
      IconData(icTravel, fontFamily: 'MaterialIcons'),
      color: deepPink,
    ),
    const Icon(
      IconData(icShop, fontFamily: 'MaterialIcons'),
      color: lightBlue,
    ),
  ];
}
