import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Request url: ${data.url}');
    print('Request headers: ${data.headers}');
    print('Request body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Response status: ${data.statusCode}');
    print('Response headers: ${data.headers}');
    print('Response body: ${data.body}');
    return data;
  }
}
