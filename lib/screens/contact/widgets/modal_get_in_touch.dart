import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/mixins/snack_mixin.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:provider/provider.dart';

class ModalGetInTouch extends StatefulWidget {
  final String formId;
  ModalGetInTouch({
    Key key,
    this.formId,
  }) : super(key: key);
  @override
  _ModalGetInTouchState createState() => _ModalGetInTouchState();
}

class _ModalGetInTouchState extends State<ModalGetInTouch> with SnackMixin, LoadingMixin {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _messController = TextEditingController();
  bool _loading = false;
  bool _validateName = false;
  bool _validateEmail = false;
  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _messController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context).translate;
    RequestHelper requestHelper = Provider.of<RequestHelper>(context);

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        return Container(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight - 140),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: itemPadding),
                  child: Text(
                    translate('contact_touch'),
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  translate('contact_questions'),
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: itemPadding * 4,
                ),
                TextField(
                  minLines: 10,
                  maxLines: 20,
                  // cursorHeight: 10,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.only(start: itemPadding * 2, top: 11),
                      labelText: translate('contact_mess'),
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignLabelWithHint: true),
                  controller: _messController,
                ),
                SizedBox(
                  height: itemPadding * 2,
                ),
                TextField(
                  decoration: InputDecoration(
                    errorText: _validateName ? 'name is required' : null,
                    contentPadding: EdgeInsetsDirectional.only(start: itemPadding * 2, top: 11),
                    labelText: translate('contact_name'),
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: _nameController,
                ),
                SizedBox(
                  height: itemPadding * 2,
                ),
                TextField(
                  decoration: InputDecoration(
                    errorText: _validateEmail ? 'email is required' : null,
                    contentPadding: EdgeInsetsDirectional.only(start: 16, top: 11),
                    labelText: translate('contact_email'),
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  controller: _emailController,
                ),
                SizedBox(
                  height: itemPadding * 3,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      try {
                        Map<String, dynamic> res = await requestHelper.sendContact(queryParameters: {
                          'your-email': _emailController.text,
                          'your-name': _nameController.text,
                          'your-subject': 'yourSub',
                          'your-message': _messController.text,
                        }, formId: widget.formId);
                        if (res['status'] != 'mail_sent') {
                          showError(context, res['message']);
                        } else {
                          showSuccess(context, res['message']);
                        }
                        setState(() {
                          _emailController.text.isEmpty ? _validateEmail = true : _validateEmail = false;
                          _nameController.text.isEmpty ? _validateName = true : _validateName = false;
                          _loading = false;
                        });
                      } on DioError catch (e) {
                        print(e);
                        setState(() {
                          _loading = false;
                        });
                      }
                    },
                    child: _loading
                        ? entryLoading(context, color: Theme.of(context).colorScheme.onPrimary)
                        : Text(translate('contact_submit')),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
