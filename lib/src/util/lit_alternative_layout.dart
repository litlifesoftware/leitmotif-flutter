import 'package:flutter/material.dart';

bool isPortraitMode(Size deviceSize) {
  return deviceSize.height > deviceSize.width;
}

double alternativeWidth(
  Size deviceSize, {
  required double portraitWidth,
  required double landscapeWidth,
}) {
  return isPortraitMode(deviceSize) ? portraitWidth : landscapeWidth;
}

double alternativeHeight(
  Size deviceSize, {
  required double portraitHeight,
  required double landscapeHeight,
}) {
  return isPortraitMode(deviceSize) ? portraitHeight : landscapeHeight;
}

double alternativeFontSize(
  Size deviceSize, {
  required double potraitFontSize,
  required double landscapeFontSize,
}) {
  return isPortraitMode(deviceSize) ? potraitFontSize : landscapeFontSize;
}

Alignment alternativeAlignment(
  Size deviceSize, {
  required Alignment portraitAlignment,
  required Alignment landscapeAlignment,
}) {
  return isPortraitMode(deviceSize) ? portraitAlignment : landscapeAlignment;
}

Matrix4 alternativeTransform(
  Size deviceSize, {
  required Matrix4 portraitTransform,
  required Matrix4 landscapeTransform,
}) {
  return isPortraitMode(deviceSize) ? portraitTransform : landscapeTransform;
}

BoxFit alternativeBoxFit(
  Size deviceSize, {
  required BoxFit portraitBoxFit,
  required BoxFit landscapeBoxFit,
}) {
  return isPortraitMode(deviceSize) ? portraitBoxFit : landscapeBoxFit;
}
