## Idempotência
Garantir que um requisição seja feita apenas uma unica vez

uma tecnica é criar um Uuid assim que abre a página do formulário que chamará o serviço de inserção seja no banco ou api.
por mais que o usuário clique em enviar o id será o mesmo e a regra do back ou banco não permitirá (assim esperamos)