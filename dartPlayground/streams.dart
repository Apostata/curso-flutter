import 'dart:async';

void main() {
  //  Streams são dados que são gerados ou recebidosde tempo em tempo.

  final Stream<int> stream =
      Stream.periodic(Duration(seconds: 2), (indice) => indice + 1).take(10);

  final Stream<int> stream1 = Stream.multi((contoller) {
    int num = 100;
    Timer.periodic(Duration(seconds: 2), (timer) {
      contoller.add(num++);
    });
  });

  // stream.listen((valor) {
  //   print(valor);
  // });
  stream1.listen((valor) {
    print(valor);
  });
}
