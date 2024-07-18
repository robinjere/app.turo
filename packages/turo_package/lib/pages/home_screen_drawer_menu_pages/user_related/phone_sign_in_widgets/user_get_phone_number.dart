import 'package:flutter/material.dart';
import 'package:turo_package/mixins/validation_mixins.dart';
import 'package:turo_package/files/app_preferences/app_preferences.dart';
import 'package:turo_package/files/hooks_files/hooks_configurations.dart';
import 'package:turo_package/files/generic_methods/utility_methods.dart';
import 'package:turo_package/pages/home_screen_drawer_menu_pages/user_related/phone_sign_in_widgets/otp.dart';
import 'package:turo_package/pages/home_screen_drawer_menu_pages/user_related/phone_sign_in_widgets/phone_field_widget.dart';
import 'package:turo_package/widgets/app_bar_widget.dart';
import 'package:turo_package/widgets/button_widget.dart';
import 'package:turo_package/widgets/generic_text_widget.dart';
import 'package:turo_package/widgets/no_internet_botton_widget.dart';
import 'package:turo_package/widgets/toast_widget.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class UserPhoneNumberPage extends StatefulWidget {
  const UserPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserPhoneNumberPageState();
}

class UserPhoneNumberPageState extends State<UserPhoneNumberPage>
    with ValidationMixin {
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  String phoneNumber = "";
  String countryDialCode = "";

  bool isInternetConnected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBarTitle: UtilityMethods.getLocalizedString("phone"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      textPhoneNumberAssociated(),
                      addPhone(),
                      navigateToOTPScreen(),
                    ],
                  ),
                ),
              ],
            ),
            bottomActionBarWidget(),
          ],
        ),
      ),
    );
  }

  Widget textPhoneNumberAssociated() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GenericTextWidget(
        UtilityMethods.getLocalizedString("enter_your_phone_number"),
        style: AppThemePreferences().appTheme.heading02TextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget addPhone() {
    return Form(
      key: phoneFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PhoneNumberFieldWidget(
            listener: (code, num) {
              phoneNumber = num;
              countryDialCode = code;
            },
          ),
        ],
      ),
    );
  }

  Widget navigateToOTPScreen() {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: ButtonWidget(
            text: UtilityMethods.getLocalizedString("send_otp"),
            onPressed: () async {
              _showToast(
                  context, UtilityMethods.getLocalizedString("otp_sent"));
              if (phoneFormKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OTPScreen(phoneNumber, countryDialCode),
                  ),
                );
              }
            }));
  }

  _showToast(BuildContext context, String msg) {
    ShowToastWidget(
      buildContext: context,
      text: msg,
    );
  }

  Widget bottomActionBarWidget() {
    return Positioned(
      bottom: 0.0,
      child: SafeArea(
        child: Column(
          children: [
            if (!isInternetConnected)
              NoInternetBottomActionBarWidget(showRetryButton: false),
          ],
        ),
      ),
    );
  }
}
