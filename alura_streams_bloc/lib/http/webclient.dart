import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:alura_streams_bloc/http/Interceptors/loggin_interceptor.dart';

final Client httpClient = InterceptedClient.build(
  interceptors: [
    LoggingInterceptor(),
  ],
  requestTimeout: const Duration(seconds: 5),
);
