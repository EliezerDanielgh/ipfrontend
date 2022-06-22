import 'package:flutter/material.dart';
import 'package:ipfrontend/src/app/components/call_to_action/call_to_action_tablet_desktop.dart';

class CallToAction extends StatelessWidget {
  final String title;
  const CallToAction(
    Key? key,
    this.title,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CallToActionTabletDesktop(title);
  }
}
