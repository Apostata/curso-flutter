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

## Padrão visual (Material)
Não é obrigatório, mas é padrão, existe também  padrão Cupertino(apple)

## Criando uma aplicação
`flutter create {nome_da_applicação}`

## Pastas 
pasta de trabalho `lib` gerenciador de pacote é o `pubspec.yaml`

## VsCode 
quando criar um projeto é possivel que não reconheça a sintaxe automaticamente.
para corrigir basta executar o comando `flutter pub get` na raiz do projeto