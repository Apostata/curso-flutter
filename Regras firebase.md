
# Firebase

## Firebase rules
esta regra diz que tanto para a colection de `orders` como para a de `usersFavorites` as permissões tanto para ler ou escrever estão relaciodadas ao id específico de cada usuário, ou seja, no order daquele usuário, por exemplo, somente ele pode ver e alterar.

```json{
  "rules": {
    "orders":{
      "$uid":{
        ".read": "$uid == auth.uid",
        ".write": "$uid == auth.uid"
      }
    },
    "userFavorites":{
      "$uid":{
        ".read": "$uid == auth.uid",
        ".write": "$uid == auth.uid"
      }
    },
    "Products":{
      ".read": "auth != null",
      ".write": "auth != null"
    }
  }
}```