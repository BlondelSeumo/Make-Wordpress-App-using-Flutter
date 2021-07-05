import 'package:cirilla/main.dart';
import 'package:dio/dio.dart';

import 'helpers/persist_helper.dart';
import 'helpers/request_helper.dart';
import 'modules/network_module.dart';
import 'modules/preference_module.dart';

abstract class AppService implements PersisLocator, NetworkLocator {
  static Future<AppService> create(
    PreferenceModule preferenceModule,
    NetworkModule networkModule,
  ) async {
    var service = await AppServiceInject.create(
      preferenceModule,
      networkModule,
    );
    return service;
  }

  MyApp get getApp;
}

class AppServiceInject implements AppService {
  final PreferenceModule _preferenceModule;
  final NetworkModule _networkModule;

  Dio _singletonDio;
  DioClient _singletonDioClient;
  PersistHelper _singletonPersistHelper;
  RequestHelper _singletonRequestHelper;

  AppServiceInject(this._preferenceModule, this._networkModule);

  static Future<AppService> create(
    PreferenceModule preferenceModule,
    NetworkModule networkModule,
  ) async {
    final injector = AppServiceInject(
      preferenceModule,
      networkModule,
    );

    return injector;
  }

  MyApp _createApp() => MyApp();

  PersistHelper _createPersistHelper() => _singletonPersistHelper ??= _preferenceModule.providerPersistHelper();

  Dio _createDio() => _singletonDio ??= _networkModule.provideDio(_createPersistHelper());

  DioClient _createDioClient() => _singletonDioClient ??= _networkModule.provideDioClient(_createDio());

  RequestHelper _createRequest() => _singletonRequestHelper ??= _networkModule.provideRequestHelper(_createDioClient());

  @override
  PersistHelper get providerPersistHelper => _createPersistHelper();

  @override
  RequestHelper get providerRequestHelper => _createRequest();

  @override
  MyApp get getApp => _createApp();
}
