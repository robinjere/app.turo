import 'package:flutter/material.dart';
import 'package:turo_package/files/app_preferences/app_preferences.dart';
import 'package:turo_package/widgets/generic_text_widget.dart';

class RealtorPositionWidget extends StatelessWidget {
  final String position;

  const RealtorPositionWidget({
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return position.isEmpty
        ? Container()
        : Container(
            padding: const EdgeInsets.only(top: 10),
            child: GenericTextWidget(
              position,
              textAlign: TextAlign.left,
              style:
                  AppThemePreferences().appTheme.homeScreenRealtorInfoTextStyle,
            ),
          );
  }
}
