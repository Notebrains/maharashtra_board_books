
import 'dart:math';

import 'package:flutter/material.dart';

class RandomHexColor {
  static const Color one = Color(0xffe74100);
  static const Color two = Color(0xff265aff);
  static const Color three = Color(0xff209c9c);
  static const Color four = Color(0xffb52ad4);
  static const Color five = Color(0xffe27539);
  static const Color six = Color(0xff2bc40e);
  static const Color seven = Color(0xff0fc5e0);
  static const Color eight = Color(0xff823fff);
  static const Color nine = Color(0xfffd2c32);
  static const Color ten = Color(0xff731fa1);
  static const Color eleven = Color(0xffea9322);
  static const Color twoleve = Color(0xff49a801);
  static const Color thirteen = Color(0xffe57e7e);
  static const Color fourteen = Color(0xffd4b00d);
  static const Color fifteen = Color(0xff40c98e);
  static const Color sixteen = Color(0xff67715a);
  static const Color seventeen = Color(0xff000000);
  static const Color eighteen = Color(0xff193890);

  List<Color> hexColor = [one, two, three, four, five, six, seven, eight, nine, ten, eleven, twoleve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen];

  static final _random = Random();

  Color colorRandom() {
    return hexColor[_random.nextInt(hexColor.length)];
  }
}