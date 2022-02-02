# HTTP
Requisições na web usando o pacote http

## instalando
`flutter pub add http`

## implementando 
```dart
import 'package:http/http.dart';

void findAll() async {
  final url = Uri.parse('http://192.168.15.9:8080/transactions');
  final response = await get(url).timeout(
          const Duration(seconds: 5),
        );;
  print(response.body);
}

```
### Timeout
Note que a o response acima está com 5 segundos de timeout, sendo assim, após 5 segundos ira terminar o processamento

podemos colocar o timeout no client que iremos usar também

```dart
 Client httpClient = InterceptedClient.build(
    requestTimeout: Duration(seconds:5)
  );
```

## interceptors
### instalando
Precisamos instalar outra dependência :
`flutter pub add http_interceptor`

### implementando
```dart
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Request url: ${data.requestUrl}');
    print('Request headers: ${data.headers}');
    print('Request body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data.toString());
    return data;
  }
}

void findAll() async {
  Client httpClient = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
    ],
    requestTimeout: Duration(seconds:5)
  );
  final url = Uri.parse('http://192.168.15.9:8080/transactions');
  final response = await httpClient.get(url)
}

```
