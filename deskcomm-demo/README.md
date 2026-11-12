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


## Prévia na internet: hospedagem gratuita

- **Endereço implantado:** https://deskcomm-crm.hatchable.site
- **Painel de administração:** https://hatchable.com/console/projects/deskcomm-crm
- **Plataforma:** Hatchable, projeto `personal`, primeira versão implantada em 12/11/2026.
- **Visibilidade atual:** privada; o endereço exige autenticação no Hatchable para visitantes comuns.
- **Para publicar na web aberta:** proprietário altera a visibilidade do projeto nas Settings do console. Conferir antes se há vaga para o único aplicativo público gratuito da conta. Não contratar plano sem autorização.
- **Código-fonte:** este GitHub é a origem; a cópia estática publicada foi enviada como snapshot da ramificação `deskcomm-demo-2026-11` e não sincroniza automaticamente novos commits.
- **Vercel:** tentativa de criar implantação em plano Hobby recebeu HTTP 403 (`forbidden`, sem permissão para criar projeto); nenhuma alteração realizada na Vercel.
- **Segurança:** demonstração **não** usa Supabase, WhatsApp ou IA e contém apenas conteúdo de teste. O Supabase Fio Cliente permanece acessível somente pelos próprios controles existentes; o laboratório `deskcomm_demo` está bloqueado para acessos de API usuais.

Veja `infra/README.md` e `infra/preflight.sh` para planejamento de futura implantação do DeskComm **original** em VPS gratuita, sem executar nada automaticamente.
