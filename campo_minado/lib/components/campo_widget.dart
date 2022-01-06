import 'package:campo_minado/models/campo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CampoWidget extends StatelessWidget {
  final Campo campo;
  final void Function(Campo) onOpen;
  final void Function(Campo) onToggleMarcacao;

  const CampoWidget({
    Key? key,
    required this.campo,
    required this.onOpen,
    required this.onToggleMarcacao,
  }) : super(key: key);

  Widget _getContentImage() {
    int qtdeMinas = campo.qtdeMinasVizinhanca;
    if (campo.aberto && campo.minado && campo.explodido) {
      return Image.asset('${kIsWeb ? "" : "assets/"}images/bomba_0.jpeg');
    } 
    else if (campo.aberto && campo.minado) {
      return Image.asset('${kIsWeb ? "" : "assets/"}images/bomba_1.jpeg');
    } 
    else if (campo.aberto) {
      return Image.asset('${kIsWeb ? "" : "assets/"}images/aberto_$qtdeMinas.jpeg');
    } 
    else if (campo.marcado){
      return Image.asset('${kIsWeb ? "" : "assets/"}images/bandeira.jpeg');
    }
    else {
      return Image.asset('${kIsWeb ? "" : "assets/"}images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(campo),
      onLongPress: () => onToggleMarcacao(campo),
      child: _getContentImage(),
    );
  }
}
