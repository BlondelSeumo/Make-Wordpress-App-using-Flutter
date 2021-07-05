import 'package:cirilla/service/helpers/persist_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersisLocator {
  PersistHelper get providerPersistHelper;
}

class PreferenceModule {
  // DI variables:--------------------------------------------------------------
  SharedPreferences sharedPref;

  // constructor
  PreferenceModule({@required this.sharedPref});

  // DI Providers:--------------------------------------------------------------
  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  PersistHelper providerPersistHelper() => PersistHelper(sharedPref);
}
