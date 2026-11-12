# Infraestrutura do DeskComm original | preparação sem custo

**Estado:** planejamento e verificação de pré-requisitos. Nenhuma VPS contratada, nenhuma aplicação original instalada, nenhuma credencial adicionada.

## 1. Separação obrigatória

- `deskcomm-demo/` é somente um **simulador estático**, com esquema fictício no Supabase **Fio Cliente**.
- NÃO aplicar `supabase/baseline.sql` do DeskComm original no projeto Fio Cliente. O original cria objetos em `public` e precisa de serviços e políticas próprias.
- O produto comercial precisará de **banco dedicado** (Supabase separado, com custo previamente aprovado) ou instalação completa de Supabase autohospedada, após validação das necessidades e recursos.
- Não ativar `WAHA`, mensagens ou IA nas demonstrações com dados fictícios sem antes verificar custos, políticas e consentimento.

## 2. Release de referência

Repositório oficial: https://github.com/melgarafael/DeskcommCRM
Release de referência consultada em 12/11/2026: `v1.109.0`.
Instalador oficial e guia: `hostgator-setup-kit/README.md`, `hostgator-setup-kit/install.sh`.
Licença original: MIT. Preservar licença, créditos e avisos obrigatórios ao preparar uma derivação.

No FUTURO servidor de testes Linux, ANTES de instalar qualquer dependência:

```bash
bash deskcomm-demo/infra/preflight.sh
```

Para inspeção manual do código da release, sem executá-lo:

```bash
git clone --depth 1 --branch v1.109.0 https://github.com/melgarafael/DeskcommCRM.git deskcomm-oficial
cd deskcomm-oficial
less hostgator-setup-kit/README.md
less hostgator-setup-kit/install.sh
```

**NÃO executar o instalador automaticamente**. O instalador altera servidor, pode instalar Docker, aplicar SQL, configurar cron e criar recursos na nuvem se credenciais estiverem disponíveis. Executar apenas depois de revisão, backup e autorização.

## 3. Alternativas de custo zero verificadas

**A. Oracle Cloud Always Free (principal candidato VPS):**
2 OCPUs ARM Ampere A1, até 12 GB RAM sob as franquias Always Free, dependendo de elegibilidade e capacidade disponível. Exige uma conta Oracle, seleção explícita de forma Always Free e região home; pode estar sem capacidade e a conta pode exigir verificação de pagamento. Não escolher tamanho/serviços acima da franquia. Fonte: https://docs.oracle.com/pt-br/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm

**B. Computador próprio + Docker:** custo adicional de hospedagem potencialmente R$ 0, porém depende de uma máquina confiável, banda, energia, IP público ou túnel e políticas de segurança; não recomendado para cliente pagante sem testes e backup.

**C. Railway/Vercel gratuito:** não escolhido para o stack completo. O DeskComm precisa de serviços persistentes e 4 GB de RAM são recomendados. Vercel Hobby somente uso pessoal/não comercial, usado apenas para testes se a conta permitir.

## 4. Critérios de aprovação da futura VPS

- Linux Ubuntu 22.04/24.04, arquitetura `amd64` ou `arm64`.
- Pelo menos 2 vCPU e 4 GiB RAM; margem de armazenamento 80 GB sugerida pelo runbook WAHA.
- Docker e Docker Compose v2 em versões suportadas.
- Domínio e HTTPS, firewall, SSH sem senha com chave e backups testados.
- Ambiente separado do banco Fio Cliente.
- Verificar configurações dos serviços e uso de memória com `docker compose config` antes de `up -d`.
- Estimar consumo de banco e tráfego com cenário realista; DeskComm tem questões relatadas de egress/polling.
- Verificar licença e condições do canal WhatsApp (Meta oficial preferencial no produto vendido).
- Não ativar cobrança, cartão, IA paga ou recurso comercial em planos gratuitos sem autorização.

## 5. Caminho para um MVP de venda

1. Testar e revisar a prévia estática, coletando feedback com dados fictícios.
2. Criar ambiente exclusivo para o DeskComm original com custo previamente cotado.
3. Subir o stack original com release fixa, HTTPS e dados fictícios.
4. Executar testes de isolamento de organização, proteção de endpoints, consumo, backup/restore, Inbox e automações.
5. Integrar WhatsApp de teste e IA com limite rígido de gasto somente após aprovações.
6. Montar proposta comercial, termos de privacidade, contrato e suporte.

**O que foi feito neste commit:** somente documentação e script de checagem. Nenhuma infraestrutura externa criada.
