# Widgets ou componentes
Resumo geral da função dos componentes nativos do flutter

## Configuração da App/Page
### APP
- MaterialApp / CupertinoApp
componente raiz

### Page
- scaffold/ CupertinoPageScaffold
Gerá um header, body e footer

## Layout
- Container
- Row
- Column
- LayoutBuilder - Mais complexo, para pegar as dimensões do componente pai para considerar responsividade
### Filhos de Widgets de Layout
Funcionam apenas em conjunto com os widgets acima

- Flexible
- Expanded 
- FittedBox - faz com que o conteúdo se encaixe das dimensões do componente pai, seja verticalmente ou horizontalmente 

#### Felxible
- fit: Determina se o elemento vai se expandir para ocupar espaços vazios ou se reter ao tamanho definido ou do conteúdo.
    1. **Fit loose** FlexFit.loose = É o padrão. Ocupa o tamanho necessário só para exibir o elemento ou a lagura definida na propriedade width
    2. **fit tight** FlexFit.tight = Ocupa todo espaço restante na linha
- flex: em casos de mais de um elemento com a propriedade **fit: FlexFit.tight** determina qual a porção cada componente ocupará do espaço vazio.
  Exemplo1: se temos 2 componente, um com flex = 1 e outro com flex = 2, teremos que os espaços vazios serão divididos por 3(flex=1 + flex=2) e o elemento com flex=2 ocupará 2/3 do espaço e elemento com flex=1 ocupará 1/3. Ou seja se ambos fossem flex=2, então daria um total de 4 e cada um ocuparia 2/4, que seria a mesma coisa de dois elementos com flex=1 pois o 2/4 = 1/2, e cada elemento ocuparia metade dos espaços vazios. 
  Exemplo2: Usando um elemento com flex=3 e outro com flex=1, só que com fit=FlexFit.loose. O resultado é que como o elemento de flex=1 está com fit=loose ele ocupará só o tamanho definido nele ou tamanho de seu conteúdo, porém o elemento de flex=3 pegará 3/4 do tamanho, deixar um espaçamento em branco correspondente ao 1/4 do espaço
#### Expanded
Expanded é a mesma coisa que o flexible só que sem a propriedade fit, que já está setado como **tight** por padrão
### Containers
- Stack
camadas(aparentemente um posicionamento absoluto) elemento dentro de outro

- Card

### Elementos de repetição
#### Listas
- ListView - ja com overflow para fazer a rolagem da tela caso o conteúdo extrapole as dimensões do container
- GridView

#### Item de lista
- ListTile - O item repetido da de uma listView, já contém diversos atributos para ficar mais facil estruturar e estilizar um item de lista

## Elementos de Conteúdo
- Text
- Image
- Icon
- CircleAvatar - uma componente já em formato circular para por conteúdo,


## IO
### Visiveis
- TextField
- ElevatedButton
- TextButton
- InkWell
- Switch - um botão do tipo switch trocar entre true ou false

### invisíveis
- GestureDetector

## BoxDecoration