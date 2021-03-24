# Flutter
Flutter é um framework para criação de applicações multiplataformas
IOS, Android, Web, Desktop(Windows, linux e MacOS)
adicionar o plugin do flutter no Vscode
é necessários alguns passos a mais para habilitar para Web e desktop, vide instalação. 

## Instalação
instalar, vscode, fluter sdk, android studio ou xcode(MacOS) java sdk 8.

*windows*: criar um novo apontamento da variavel de ambiente PATH para bin, dentro a pastar extraida do sdk do fluter:
exemplo: `C:\DEV\fluter\bin`

### Suporte para Desktop
Aplicativos já existentes: https://flutter.dev/desktop#add-desktop-support-to-an-existing-app.  
Rodar o comando na pasta raiz do projeto: `flutter create --platforms=windows,macos,linux`

Novos apps: https://flutter.dev/desktop.

### Suporte para Web
Aplicativos já existentes: `flutter create .`
Novos apps:https://flutter.dev/docs/get-started/web
rodar os commandos:
`flutter channel stable`
`flutter upgrade`
`flutter devices` : lista de devices, no meu caso Chrome sera usado para web
`flutter run -d chrome` 
 
 **NOTA: tanto para web ou desktop estes comandos devem ser executados na raiz do projeto**

### Rodando em seu dispositivo


## Padrão visual (Material)
Não é obrigatório, mas é padrão, existe também  padrão Cupertino(apple)

## Criando uma aplicação
`flutter create {nome_da_applicação}`

## Pastas 
pasta de trabalho `lib` gerenciador de pacote é o `pubspec.yaml`

## VsCode 
quando criar um projeto é possivel que não reconheça a sintaxe automaticamente.
para corrigir basta executar o comando `flutter pub get` na raiz do projeto

## main.dart
O código inicial da aplicação
### Estrutura padrão
#### Classe inicial do App (olá mundo)
```dart
import 'package:flutter/material.dart';
class MeuApp extends StatelessWidget {...}

main() => runApp(MeuApp())
```
onde StatelssWidget é um widget sem estado mas é o como se fosse o React.Component do react
e runApp é o inicio da aplicação criando uma nova instancia de MeuApp

dentro da classe inicial temos um metodo build, Este metodo está com o anotation `@override`, que significa que ele se pega o metodo `build` de `StatelessComponent` e irá sobrescreve-lo com um novo comportamento baseado na função build pré-existente. A função build irá aguarda um  retorno de um tipo `Widget`, passando um parametro do tipo `BuildContext`
:
```dart

class MeuApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        ...
    }
}
main() => runApp(MeuApp())
```

dentro da função build criamos um widget, através de composição (classes que são atributos de outras).
Usando, neste caso o tema `Material` que retornaremos o tipo `Widget` ao chamar a função `MaterialApp()` importada do pacote `package:flutter/material.dart`  :
```dart
import 'package:flutter/material.dart';

main(List<String> args) => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override //anotation ou decorator
  Widget build(BuildContext context) {
    //composição
    return MaterialApp(
      home: Scaffold(
        //estrutura
        appBar: AppBar(
          title: Text('Aks and Questions'),
        ),
        body: Text('Olá flutter!'),
      ),
    ); //cria uma instancia de MaterialApp
  }
}
```

## Widget (componente)
Widget é o componente padrão do Flutter como no react usar um componente de classe ou funcional, neste casso é chamado de Widget  

### metodo build
é o metodo que renderiza o componente, como o metodo render do React em componentes de classe.

widgets podem receber um Widget filho ou uma lista de widgets `List<Widget>` 
### Widgets visiveis e invisíveis
- Visíveis são componentes que fazem parte do layout, renderizando algo na tela (que tem estilo)
exemplos: `ElevatedButton(), Text(), Card()`

- Invisíveis podem ou não renderizar mas não é perceptivel ao usuário (não tem estilo, estruturais apenas).
*Para quem vem do js seria como se fosse as estruturas do grid do `Material-ui` ou `Bootstrap`*
exemplos: `Row(), Collumn(), ListView()`


- existe um componente que é o `Container()`, se trata de um híbrido, pode ser invisível ou visível

**Nota do curso:No lugar de um FlatButton, usaremos TextButton. No lugar de RaisedButton, usaremos ElevatedButton**

#### Exemplo de grid no Flutter:
Onde body tem possúi uma lista(1 ou mais) o Widget(s) `Row` (invisível) que possúi uma lista(1 ou mais) Widget(s) `Column` (invisível), que pode também possúir 1 ou mais Widgets, neste caso, possúi, um Widget
`Text` e um Widget `ElevatedButton` 

```dart
import 'package:flutter/material.dart';

main(List<String> args) => runApp(AsksAndQuestionsApp());

class AsksAndQuestionsApp extends StatelessWidget {
  @override //anotation ou decorator
  Widget build(BuildContext context) {
    final List<String> perguntas = [
      'Qual é a sua cor favorita?',
      'Qual o seu animal favorito?'
    ];

    //composição
    return MaterialApp(
      home: Scaffold(
        //estrutura
        appBar: AppBar(
          title: Text('Aks and Questions'),
        ),
        body: Row(
          children: [
            Column(
              children: [
                Text(perguntas[0]),
                ElevatedButton(
                  child: Text('Resposta 1'),
                  onPressed: null,
                ),
              ],
            ),
          ],
        ),
      ),
    ); //cria uma instancia de MaterialApp
  }
}

```
### Eventos
Conectar eventos ao click de um Widget do tipo botão
Exatamente como no React, criamos uma função para o click (onPressed)
passar uma closure e então é possível passar algum parametro, já que onPressed só aceita funções `Void` e sem parametros.

```dart
import 'package:flutter/material.dart';

main(List<String> args) => runApp(AsksAndQuestionsApp());

class AsksAndQuestionsApp extends StatelessWidget {
  void responder(int numero) {
    print('Pergunta $numero respondida!');
  }

  @override //anotation ou decorator
  Widget build(BuildContext context) {
    final List<String> perguntas = [
      'Qual é a sua cor favorita?',
      'Qual o seu animal favorito?'
    ];

    //composição
    return MaterialApp(
      home: Scaffold(
        //estrutura
        appBar: AppBar(
          title: Text('Aks and Questions'),
        ),
        body: Row(
          children: [
            Column(
              children: [
                Text(perguntas[0]),
                ElevatedButton(
                  child: Text('Resposta 1'),
                  onPressed: () => responder(1),
                ),
                ElevatedButton(
                  child: Text('Resposta 2'),
                  onPressed: () => responder(2),
                ),
                ElevatedButton(
                  child: Text('Resposta 3'),
                  onPressed: () => responder(3),
                )
              ],
            ),
          ],
        ),
      ),
    ); //cria uma instancia de MaterialApp
  }
}

```

### Widgets StateLess e StateFull
como no react todos os componentes sejam stateLess ou stateFull, os parametros passados para o construtor, podem ser alterados pelos seus componentes pais, fazendo um comparativo com React, seriam os props.
Quandos componentes recebem parametros novos, são re-renderizados.

Assim como no React também podemos passar alterações de estado dos componentes

#### Statefull components(ou widgets)
Alem dos parametros passados a eles, também possuem um estado interno, que também força a re-renderização assim que este estado é mudado(da mesma forma que o React).
A implementação de um stateFull componente (Widget) é um pouco diferente.
Primeiramente é nessessário criar sua classe customizada, no caso `MyClass`(este nome é só um exemplo) extendendo do tipo `StatefullWidget`.Depois é necessário criar uma classe, com o nome `_MyClassState`(este nome é só um exemplo) de forma privada para gerenciamenteo do esdado que irá extender do tipo `State` genérco do tipo `MyClass`, que será a classe customizada a ser criada.

**NOTA: flutter já possúi otimização para re-renderizar apenas o necessário**

```dart
class _MyClassState_ extends State<MyClass> {
    ...
}

class MyClass extends StatefulWidget {
    ...
}
```

Como a renderização depende do estado, neste caso, então todo o metodo `build` será implementado na classe `MyClassState` criada para o gerenciamento do estado.
Então na classe principal, que seria o `MyClass` criar um metodo `createState`, que deve retornar o tipo 
`MyClassState`. Esta função retornará apenas uma instancia da classe `MyClassState`.

```dart
class _MyClassState_ extends State<MyClass> {
    ...
}

class MyClass extends StatefulWidget {
    _MyClassState_ createState() {
        return _MyClassState_();
    }
}
```

E então para alterar o estado da classe `MyClass`. basta usar o metoto `setState()` envolvendo a variavel a ser alterada.
exemplo da aplicação completa

```dart
class _MyClassState extends State<MyClass> {
  int _perguntaSelecionada_ = 0;

  void _responder_(int numero) {
    setState(() {
      _perguntaSelecionada_++;
    });

    print('Pergunta $numero respondida!');
  }

  @override //anotation ou decorator
  Widget build(BuildContext context) {
    final List<String> perguntas = [
      'Qual é a sua cor favorita?',
      'Qual o seu animal favorito?'
    ];

    //composição
    return MaterialApp(
      home: Scaffold(
        //estrutura
        appBar: AppBar(
          title: Text('Aks and Questions'),
        ),
        body: Row(
          children: [
            Column(
              children: [
                Text(perguntas[_perguntaSelecionada_]),
                ElevatedButton(
                  child: Text('Resposta 1'),
                  onPressed: () => _responder_(1),
                ),
                ElevatedButton(
                  child: Text('Resposta 2'),
                  onPressed: () => _responder_(2),
                ),
                ElevatedButton(
                  child: Text('Resposta 3'),
                  onPressed: () => _responder_(3),
                )
              ],
            ),
          ],
        ),
      ),
    ); //cria uma instancia de MaterialApp
  }
}

class MyClass extends StatefulWidget {
  @override
  _MyClassState createState() {
    return _MyClassState();
  }
}
```
#### Subdividindo em componentes(Widgets) menores

#### Widget Container
atributos 
    child
    padding
    border
    margin
tirando o child o resto é como no css na web

**NOTA: alguns componentes tem padding e outros não. Para aplicar o padding em componentes que não tenham, basta envolver o componente com o Widget Padding()**

##### aplicando estilo