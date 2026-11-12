# DeskComm CRM | demonstração isolada

**Status:** protótipo estático e banco fictício de laboratório. **Não é o aplicativo DeskComm original instalado.**

Este diretório foi adicionado a uma **ramificação separada** de um repositório antigo, para não alterar o aplicativo de almoxarifado existente na branch `main`.

## O que existe

- `web/index.html`: demonstração estática interativa de CRM comercial para uma oficina fictícia; não se comunica com rede, API, WhatsApp ou IA.
- `sql/001_schema.sql`: modelo isolado `deskcomm_demo`, aplicado anteriormente ao projeto Supabase *Fio Cliente*.
- `sql/002_seed.sql`: contatos, negócios, conversas e textos de conhecimento **fictícios**.
- `sql/003_checks.sql`: checagem de contagens e permissões do banco.

**Segurança:** o esquema de laboratório tem RLS habilitado e forçado, sem políticas de acesso de clientes e sem privilégios de leitura para `anon`, `authenticated` ou `service_role`. Não está exposto na Data API. Não executar o `baseline.sql` do DeskComm original neste Supabase, pois ele compartilha `public` com outros sistemas.

**Resultados verificados no Fio Cliente:** 1 empresa, 5 contatos, 5 oportunidades, 6 mensagens e 3 textos de conhecimento. Nenhum número real, token ou chave consta neste repositório.

## Uso do protótipo

Abra `web/index.html` no navegador. As alterações no quadro e conversas duram somente enquanto a página está aberta, sem gravação no banco.

## Evolução técnica necessária

1. Manter `main` e suas configurações de publicação intactas; trabalhar exclusivamente nesta ramificação.
2. Revisar proteção de dados e custos antes de criar ambiente dedicado para o DeskComm real.
3. Para o sistema real, verificar release fixa em https://github.com/melgarafael/DeskcommCRM e licença MIT do autor original. Este diretório **não contém uma cópia** do CRM original.
4. Preferir VPS Linux com Docker Compose para os serviços persistentes. Não provisionar hospedagem nem contratar plano pago sem autorização.
5. Testar o WhatsApp em homologação antes de qualquer mensagem real, com canal autorizado, opt-in e limites de consumo.

**Não inserir dados pessoais reais neste piloto.**
