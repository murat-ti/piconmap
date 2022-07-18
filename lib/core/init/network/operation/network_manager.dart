import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../constants/app/app_constants.dart';
import '../model/empty_model.dart';
import '../interface/INetworkManager.dart';
import '../interface/INetworkModel.dart';
import '../interface/IResponseModel.dart';
import '../model/error_model.dart';
import '../model/response_model.dart';
import '../../../constants/enums/request_type.dart';
import '../../../extension/network_extension.dart';
part 'network_model_parser.dart';

class NetworkManager with DioMixin implements Dio, INetworkManager {
  late INetworkModel? errorModel;

  NetworkManager({
    required BaseOptions options,
    bool? isEnableLogger,
    InterceptorsWrapper? interceptor,
    this.errorModel,
  }) {
    this.options = options;
    _addLoggerInterceptor(isEnableLogger ?? false);
    //_addNetworkIntercaptors(interceptor);
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  @override
  Future<IResponseModel<R?>> send<T extends INetworkModel, R>(
    String path, {
    required T parseModel,
    required RequestType method,
    String? urlSuffix = '',
    Map<String, dynamic>? queryParameters,
    Options? options,
    Duration? expiration,
    CancelToken? cancelToken,
    dynamic data,
    ProgressCallback? onReceiveProgress,
  }) async {
    options ??= Options();
    options.method = method.stringValue;
    final body = _getBodyModel(data);

    if (await isInternet()) {
      try {
        late final Response response;

        response = await request('$path$urlSuffix', data: body, options: options, queryParameters: queryParameters);

        switch (response.statusCode) {
          case HttpStatus.ok:
              return _getResponseResult<T, R>(response.data, parseModel);
          default:
            return ResponseModel(error: ErrorModel(description: response.data.toString()));
        }
      } on DioError catch (e) {
        return _onError<R>(e);
      }
    } else {
      return ResponseModel(error: ErrorModel(description: 'Please connect to the internet and try again.'));
    }
  }

  ResponseModel<R> _getResponseResult<T extends INetworkModel, R>(dynamic data, T parserModel) {
    final model = _parseBody<R, T>(data, parserModel);
    return ResponseModel<R>(data: model);
  }

  ResponseModel<R> _onError<R>(DioError e) {
    final errorResponse = e.response;
    _printErrorMessage(e.message);
    final error = ErrorModel(
        description: e.message,
        statusCode: errorResponse != null ? errorResponse.statusCode : HttpStatus.internalServerError);
    if (errorResponse != null) {
      _generateErrorModel(error, errorResponse.data);
    }
    return ResponseModel<R>(error: error);
  }

  void _printErrorMessage(String message) {
    if (ApiConstants.LOGGER_ENABLED) {
      Logger().e(message);
    }
  }

  void _generateErrorModel(ErrorModel error, dynamic data) {
    if (errorModel == null) return;
    final _data = data is Map ? data : jsonDecode(data);
    error.model = errorModel!.fromJson(_data);
  }

  void _addLoggerInterceptor(bool isEnableLogger) {
    if (isEnableLogger) interceptors.add(LogInterceptor());
  }

  void setHttpClientAdapter() {
    httpClientAdapter = DefaultHttpClientAdapter();
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<bool> isInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
