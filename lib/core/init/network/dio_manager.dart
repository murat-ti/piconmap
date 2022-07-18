import 'package:dio/dio.dart';
import '../../constants/app/app_constants.dart';
import 'interface/INetworkManager.dart';
import 'operation/network_manager.dart';

class DioManager {
  static DioManager? _instance;
  static DioManager get instance {
    _instance ??= DioManager._init();
    return _instance!;
  }

  Dio? _dio;
  Dio get dio => _dio ?? Dio();

  static final BaseOptions _baseOptions = BaseOptions(
      baseUrl: ApiConstants.MAP_SERVER_URL,
      connectTimeout: ApiConstants.CONNECTION_TIMEOUT,
      receiveTimeout: ApiConstants.CONNECTION_TIMEOUT,
      headers: {
        'app': 'PicOnMap'
      }
  );

  DioManager._init(){
    _dio = Dio(_baseOptions);

    //check bad certificate
    /*(_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };*/

  }

  INetworkManager networkManager = NetworkManager(
      isEnableLogger: ApiConstants.LOGGER_ENABLED,
      options: _baseOptions);
}
