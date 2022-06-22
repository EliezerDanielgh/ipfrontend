import 'package:flutter/material.dart';
import 'package:ipfrontend/src/app/ui/widgets/progress_indicators/custom_progress_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CustomProgressIndicator());
  }
}
