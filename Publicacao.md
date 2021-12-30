# Publicando / usando em produção

## Android
Referência : https://docs.flutter.dev/deployment/android

### Configurando ID da aplicação
Mudar packagee ou aplicationId do projeto nos arquivos `AndroidManifest.xml`, `build.gradle` `MainActivity.kt` para um nome único, exemplo: `br.com.{SEU_DOMINIO}.{NOME_DO_PROJETO}` 

o arquivo `{PATH_DO_PROJETO}\{NOME_DO_PROJETO}\android\app\src\main\AndroidManifest.xml`
é onde ficam as configurações para produção, em desenvolvimento o FLutter usa o 
`{PATH_DO_PROJETO}\{NOME_DO_PROJETO}\android\app\src\debug\AndroidManifest.xml`.

Caso seu projeto use a internet, copie a configuração de permissão de internet que está no `AndroidManifest.xml` do caminho de `debug`. e adicione quaisquer permissões necessárias para produção.

### Assinando

On Mac/Linux, use the following command:
  `keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`

On Windows, use the following command:
  `keytool -genkey -v -keystore c:\Users\USER_NAME\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048` 

Criar o arquivo `key.properties` na pasta `android/`

```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=upload
storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>
```

Alterar arquivo `/android/app/build.gradle`, adicionando as informações da chave antes do bloco android

```gradle
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }

   android {
         ...
   }
```

no mesmo arquivo, subistitua o código abaixo:
```gradle
 buildTypes {
       release {
           // TODO: Add your own signing config for the release build.
           // Signing with the debug keys for now,
           // so `flutter run --release` works.
           signingConfig signingConfigs.debug
       }
   }
```

 por:

```gradle
 signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
   buildTypes {
       release {
           signingConfig signingConfigs.release
       }
   }
```
Rodar os commandos 
`flutter clean` e logo após `flutter build appbundle`
e caso esteja dando erros de dependências na IDE, rodar o comanto `flutter pub get`

### Pagamento
é necessário pagar uma taxa de US$25,00, no momento ta osso

## MAC
...sem mac no momento, adquirir um MackBook

## Versionamento
1.0.0 = major.minor.patch

