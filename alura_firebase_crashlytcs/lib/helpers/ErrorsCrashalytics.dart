import 'package:alura_firebase_crashlytcs/errors/httpException.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void sendCrashalytics(error, String serviceInstanceString) {
  if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
    final bool isHttpException = error is HttpException;
    final int statusCode = isHttpException ? error.statusCode! : 0;
    final String message = isHttpException ? error.message : error.toString();

    FirebaseCrashlytics.instance.setCustomKey('exception', message);
    FirebaseCrashlytics.instance
        .setCustomKey('http-body', serviceInstanceString);
    FirebaseCrashlytics.instance.setCustomKey('http-code', statusCode);
    FirebaseCrashlytics.instance.recordError(error, null);
  }
}
