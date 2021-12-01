# Padrões de projeto

## classe singleton
Uma classe que tem uma única instância

```dart
class Contador{
    int valor = 1;
    static final single = Contador._();
    Contador._();

    int inc(){
        valor++;
        return valor;
    }
}
```
exemplo de implementação:

```dart
void main(){
    print(Contador.single.inc()); // retorno será 2
    print(Contador.single.inc()); // retorno será 3
    print(Contador.single.inc()); // retorno será 4
}
```
O mesmo resultado pode ser feito com uma classe normal com a atributo `valor` como estática, apesar de termos várias instancias da mesma classe a atributo `valor` pertence a classe e não as instancias dela:

```dart
class Contador{
    static int valor = 1;
    Contador();

    int inc(){
        valor++;
        return valor;
    }
}
```
exemplo de implementação:

```dart
void main(){
    print(Contador.inc()); // retorno será 2
    print(Contador.inc()); // retorno será 3
    print(Contador.inc()); // retorno será 4
}
```