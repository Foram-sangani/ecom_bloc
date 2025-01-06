import 'package:dio/dio.dart';

import '../../utils/ui_utils.dart';
import 'api_class.dart';

class APIFunction {
  APIFunction._();

  /// ***********************************************************************************
  ///                                    OPTIONS & HEADER
  /// ***********************************************************************************

  static Options getOptionsAndHeader({
    Duration? receiveTimeout,
    /* required Rx<AppFlowType> appFlowType*/
  }) =>
      Options(
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 7),
        headers: {
          "Content-Type": "application/json",
          // "Authorization": "Bearer ${appFlowType.value == AppFlowType.normal ? LocalStorage.accessToken.value : OnboardLocalStorage.accessToken.value}",
          // "platform": APIPlatform.app.name,
        },
      );

  /// ------ To Call Post API -------------------->>>
  static Future<dynamic> postApiCall({
    required String apiName,
    dynamic params,
    dynamic body,
    bool? isDecode,

    /// `null` or `Duration.zero` means no timeout limit.
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).post(
        withBaseUrl == true ? (HttpUtil.apiUrl + apiName) : apiName,
        isDecode: isDecode ?? false,
        body: body,
        queryParameters: params,
        options: getOptionsAndHeader(
          receiveTimeout: receiveTimeout, /*appFlowType: baseCon.appFlowType*/
        ),
      );
      return response;
    }
  }

  /// ------ To Call Put API -------------------->>>
  static Future<dynamic> putApiCall({
    required String apiName,
    dynamic params,
    dynamic body,
    bool? isDecode,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).put(
        withBaseUrl == true ? (HttpUtil.apiUrl + apiName) : apiName,
        isDecode: isDecode ?? false,
        body: body,
        queryParameters: params,
        options: getOptionsAndHeader(
          receiveTimeout: receiveTimeout, /* appFlowType: baseCon.appFlowType*/
        ),
      );
      return response;
    }
  }

  /// ------ To Call Get API -------------------->>>
  static Future<dynamic> getApiCall({
    required String apiName,
    dynamic body,
    bool? isDecode,
    dynamic params,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
  }) async {
    // if (await getConnectivityResult()) {
    dynamic response = await HttpUtil(errorToast: showErrorToast).get(
      /*withBaseUrl == true ? (HttpUtil.apiUrl + apiName) : */ apiName,
      body: body,
      queryParameters: params,
      isDecode: isDecode ?? false,
      options: getOptionsAndHeader(
        receiveTimeout: receiveTimeout, /*appFlowType: baseCon.appFlowType*/
      ),
    );
    return response;
    // }
  }

  /// ------ To Call Post API -------------------->>>
  static Future<dynamic> deleteApiCall({
    required String apiName,
    dynamic body,
    dynamic prams,
    bool? isDecode,
    Duration? receiveTimeout,
    bool withBaseUrl = true,
    bool showErrorToast = true,
  }) async {
    if (await getConnectivityResult()) {
      dynamic response = await HttpUtil(errorToast: showErrorToast).delete(
        withBaseUrl == true ? (HttpUtil.apiUrl + apiName) : apiName,
        body: body,
        isDecode: isDecode ?? false,
        queryParameters: prams,
        options: getOptionsAndHeader(
          receiveTimeout: receiveTimeout, /*appFlowType: baseCon.appFlowType*/
        ),
      );
      return response;
    }
  }
}
