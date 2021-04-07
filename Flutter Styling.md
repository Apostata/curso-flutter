# Styling widgets

## Padding Widget
Permite a inserção de estilos customizados.
- padding
  
exemplo:
```Dart
Padding(
    padding: EdgeInsets.all(10),
    child: Text(...)
)
```

## Container widget
aceita apenas um elemento *child*
tem largura flexivel, largura do filho, largura disponível e pode ser fixa se desejar
Permite a inserção de estilos customizados.
- margin
- padding
- decoration

margin e border utilizam o EdgeInsets,

### EdgeInsets
EdgeInsets possuem alguns metodos, dentre eles, 
- symmetric
  onde você pode definir a margin ou pagging vertical e/ou horizontal
  exemplo:

```dart
Container(
    margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertital: 10,
    )
    child: Text(...)
)
```
- all, define igualmente as 4 margins ou padings, exeplo:

```dart
Container(
    padding: EdgeInsets.all(10),
    child: Text(...)
)
```

### BoxDecoration
define estilos de bordas
exemplo:

```dart
Container(
    margin: ...
    padding: ...
    decoration: BoxDecoration(
        border: Border.all(
            color: Colors.black,
            width: 2
        )
    ),
    child: Text(...)
)
```

## Row e Column
aceita uma lista de elementos *children*
tem limitações de customização, apenas de posições e direcionamento
tem largura fixa, ocupa ou largura(Row) ou altura(Column) toda
