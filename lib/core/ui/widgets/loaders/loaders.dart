import 'package:flutter/material.dart';
import 'package:gestor_fire/core/ui/widgets/loaders/app_loader/app_loader.dart';

sealed class Loaders {
  static Widget get appLoader => const AppLoader();
}
