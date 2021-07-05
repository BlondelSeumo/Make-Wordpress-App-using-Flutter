import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCode extends StatefulWidget {
  VerifyCode({
    Key key,
  }) : super(key: key);

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  String _currentText = "";
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    TranslateType translate = AppLocalizations.of(context).translate;

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            translate('login_mobile_title_verify'),
            style: textTheme.subtitle1,
          ),
          SizedBox(
            height: 48,
          ),
          PinCodeTextField(
            length: 6,
            obscureText: false,
            obscuringCharacter: '*',
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8),
              fieldHeight: 48,
              fieldWidth: 48,
              activeFillColor: Colors.transparent,
              inactiveFillColor: Colors.transparent,
              inactiveColor: theme.dividerColor,
              borderWidth: 1,
            ),
            keyboardType: TextInputType.number,
            controller: textEditingController,
            // errorAnimationController: errorController,
            onCompleted: (v) {
              // Navigator.pop(context, v);
            },
            backgroundColor: Colors.transparent,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            onChanged: (value) {
              setState(() {
                _currentText = value;
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
            appContext: context,
            pastedTextStyle: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
            animationType: AnimationType.fade,
            validator: (v) {
              if (v.length < 6) {
                return null;
              } else {
                return null;
              }
            },
            cursorColor: Colors.black,
            animationDuration: Duration(milliseconds: 300),
            textStyle: TextStyle(fontSize: 20, height: 1.6),
            enableActiveFill: true,
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                translate('login_mobile_description_code'),
                style: textTheme.bodyText1,
              ),
              TextButton(
                onPressed: () => {},
                child: Text(
                  translate('login_mobile_btn_send').toUpperCase(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _currentText.length < 6 ? null : () => Navigator.pop(context, _currentText),
              child: Text(translate('login_mobile_btn_verify')),
            ),
          ),
        ],
      ),
    );
  }
}
