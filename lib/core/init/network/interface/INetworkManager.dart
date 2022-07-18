import 'package:dio/dio.dart';
import '../../../constants/enums/request_type.dart';
import 'INetworkModel.dart';
import 'IResponseModel.dart';

abstract class INetworkManager {
  Future<IResponseModel<R?>> send<T extends INetworkModel, R>(
      String path, {
        required T parseModel,
        required RequestType method,
        String? urlSuffix,
        Map<String, dynamic>? queryParameters,
        Options? options,
        Duration? expiration,
        CancelToken? cancelToken,
        dynamic data,
        ProgressCallback? onReceiveProgress,
      });
}