# Configurando DDNS para externalizar uma api ou um servidor local

## Criando conta no noip
https://www.noip.com/

no roteador na aba avançado

Na seção de DDNS
no caso do noip configurar
Provedor: noip.com
nome de usuário: {{NOME_CRIADO_NO_SITE_NOIP}}
password: {{SENHA_CRIADA_NO_SITE_NOIP}}
nome do host de ddns: {{HOST_CRIADO_NO_SITE_NOIP}}

Na seção Encaminhamento de portas

Ip interno: {{IP_DA_SUA_MAQUINA}}
Porta interna: {{PORTA_USADA_PELO_SERVIDOR_LOCAL}}
Porta externa: 80 
Protocolo: ambos ou TCP somente
