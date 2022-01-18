# Flutter 

## instalanção
https://docs.flutter.dev/get-started/install
instalar o `android studio` : https://developer.android.com/studio

## Verificar instalação e setup do projeto
no terminal dentro da pasta do projeto : `flutter doctor`

## concordando com os termos de licensa do android (Android)
no terminal, na pasta do projeto: `flutter doctor --android-licenses`

## verificando se tem algum emulador
`flutter emulators`

## rodando emulador
`flutter emulators --lauch {ID_DO_EMULADOR}`

## rodando o projeto
`flutter run` 

## Suporte para desktop

### windows
instalar o Visual studio com o pacode `Desktop development with C++`
então:
rodar o comando no terminal, na pasta do projeto: `flutter config --enable-windows-desktop`
e
`flutter channel master`
`flutter upgrade`
`flutter config --enable-windows-uwp-desktop`

## Suporte para web
### Criar novo projeto com supporte para web
no terminal, na pasta do projeto: 
`flutter channel stable`
`flutter upgrade`

ao executar o comando `flutter devices`, você irá verificar que terá (se o chrome estiver instalado) o device em chome no edge da mesma forma

Executando em dev : `flutter run -d chrome` 
gerando build : `flutter build web` 

### Adicionando suport web a um projeto já existente
no terminal, na pasta do projeto: `flutter create .`

## HotReload
No curso da Alura o professor comenta em deixar função `main()` da seguinte forma, para que o `HotReload` funcione perfeitamente

```dart
void main() {
  runApp(const ByteBank());
}
```