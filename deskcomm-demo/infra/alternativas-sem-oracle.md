# DeskComm CRM | alternativas SEM Oracle (pesquisa 12/11/2026)

Objetivo: colocar o DeskComm original em ambiente Linux/Docker, sem contratação não autorizada; ou, caso a prioridade absoluta seja **R$ 0 recorrente**, criar um **MVP independente**, com arquitetura diferente.

## Requisitos verificados do original

Runbook oficial: 2 vCPU / 4 GB RAM recomendados, SSD ~80 GB, Docker Compose v2 e HTTPS. WAHA mantém sessões e requer estabilidade. Repositório e kit: https://github.com/melgarafael/DeskcommCRM/tree/main/hostgator-setup-kit

O laboratório em `deskcomm-demo` não é o DeskComm original; Fio Cliente contém esquema isolado e restrito `deskcomm_demo`. **Não aplicar o baseline original no projeto Fio Cliente**, que possui outros sistemas em `public`.

## Alternativa A: AWS Free Plan (preferencial para testar o CRM ORIGINAL)

- [AWS Nível Gratuito](https://aws.amazon.com/pt/free/)
- Conta nova: US$ 100 em créditos, com até mais US$ 100 mediante ações elegíveis; uso gratuito **até seis meses ou até os créditos se esgotarem**, sem cobrar automaticamente na modalidade Free. Pode exigir verificação de identidade; não escolher plano Paid.
- EC2 `m7i-flex.large`: **2 vCPU / 8 GiB RAM** e consta entre tipos marcados como elegíveis ao novo programa Free Tier. Confirmar na região da conta e na simulação de custos, sem presumir disponibilidade.
- A máquina, volume EBS, tráfego e IP podem consumir créditos. **Não é 8 GB grátis indefinidamente nem garante 6 meses**.
- Fonte: https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/ec2-free-tier-usage.html
- Memória/CPU: https://docs.aws.amazon.com/ec2/latest/instancetypes/gp.html
- Precisa de conta AWS do proprietário e provisionamento autorizado; nenhum deles foi criado via ChatGPT.

### Checklist de provisionamento SEM cobrar

1. Cadastrar-se na AWS **Free Plan**; não fazer upgrade para Paid.
2. Confirmar créditos, expiração e regiões elegíveis antes de criar recursos.
3. Escolher Ubuntu LTS gratuito, EC2 `m7i-flex.large` somente se console mostrar elegibilidade.
4. Conferir preço estimado e débitos contra crédito; não criar recursos extras. Dimensionar disco SSD EBS conforme necessidade e saldo.
5. Criar somente chaves SSH; bloquear portas de banco, WAHA e painel interno no firewall. Expor apenas HTTPS e SSH restrito.
6. Avaliar se 8GB bastam para DeskComm mais banco Supabase self-hosted; executar `preflight.sh`. NÃO assumir que 8GB garantem a stack completa (11 serviços adicionais, entre outros).
7. Banco de dados deve ser **dedicado**. Supabase Fio Cliente não é destino do baseline original. A conta já possui dois projetos ativos; um novo projeto Supabase grátis não está garantido.
8. Aplicar release fixa do DeskComm após revisão do instalador, sem IA/WhatsApp reais no primeiro teste. Medir consumo e custos diariamente.
9. Marcar data de desligamento antes do fim do Free Plan / créditos e preparar backups e migração.
10. Não colocar clientes pagantes nesse laboratório que expira sem plano de continuidade.

## Alternativa B: Google Cloud Free Trial (outro teste do original)

- US$ 300 em crédito por **90 dias**, conforme elegibilidade. Conta de trial não cobra automaticamente sem upgrade, mas recursos param ao fim/crédito.
- É possível investigar uma VM de 2 vCPU / 4GB com orçamento do crédito; confirmar na calculadora regional ANTES.
- O Always Free `e2-micro` de ~1GB não é adequado ao DeskComm original (regiões elegíveis EUA, 30GB disco, 1GB tráfego de saída).
- https://cloud.google.com/signup-faqs?hl=pt-BR
- https://docs.cloud.google.com/free/docs/free-cloud-features?hl=pt-br

## Alternativa C: Cloudflare Workers + D1 + Pages (MVP LEVE, NÃO O ORIGINAL)

- Aplicação reescrita para serverless, sem Docker, WAHA e serviços sempre ligados.
- Workers Free: 100 mil requisições/dia, até 10ms CPU por execução.
- D1 Free: 5 milhões linhas lidas/dia; 100 mil linhas gravadas/dia; 500MB por banco, 5GB por conta, 10 bancos. Limites interrompem chamadas, sem garantia de escalabilidade.
- Pages Free: até 500 builds/mês e 100 domínios personalizados por projeto.
- Frontend e API do CRM poderão usar autenticação robusta, separação de empresas, funil, contatos, chat via canal **oficial Meta Cloud API** (cobrança por mensagem conforme uso, fora da franquia Cloudflare). IA também demanda serviço e cotas próprias.
- **Não portar o DeskComm como se fosse drop-in**: exige reprojeto e implementação nova, testes de segurança e políticas de privacidade.
- https://developers.cloudflare.com/workers/platform/limits/
- https://developers.cloudflare.com/d1/platform/limits/
- https://developers.cloudflare.com/pages/platform/limits/
- Não há conector Cloudflare disponível neste chat; a conta e o deploy exigem conexão ou ações do proprietário.

## Alternativas que NÃO atendem ao objetivo do CRM original

| Provedor | Motivo |
|---|---|
| Render Free | serviços dormem, sem disco persistente gratuito e 750 horas de instância total/mês; projeto oficial não é suportado desse modo |
| Railway Free | 512MB por serviço e crédito de US$ 1/mês após teste; insuficiente para stack persistente |
| Koyeb Free | 512MB / 0.1 vCPU; suspende sem tráfego e não possui volume persistente gratuito |
| Google Cloud Always Free | VM e2-micro ~1GB e tráfego de saída muito limitado |
| Microsoft Azure 12 meses | VMs inclusas B1s/B2pts-v2/B2ats-v2 são pequenas; não fornecem o perfil completo recomendado para a stack |
| Hugging Face Spaces | Static grátis; Spaces Gradio/Docker agora requerem plano pago. Ainda têm suspensão e disco não persistente |
| Hatchable Free | ótimo para **demonstração**, mas a política de uso proíbe usar projetos gratuitos como infraestrutura de **produção para clientes pagantes** |

Fontes:
- https://render.com/docs/free
- https://docs.railway.com/pricing/free-trial
- https://docs.railway.com/pricing/plans
- https://www.koyeb.com/docs/reference/instances
- https://azure.microsoft.com/pt-br/pricing/purchase-options/azure-account/
- https://huggingface.co/docs/hub/spaces-overview
- https://hatchable.com/acceptable-use
- https://hatchable.com/pricing

## Conclusão

**Mais rápido para validar o ORIGINAL com R$ 0 inicial:** AWS Free Plan, EC2 m7i-flex.large se elegível, com gestão rígida de créditos e data de saída. Google Cloud Free Trial é segundo teste temporário.

**Mais realista para um serviço pequeno sem VPS e com R$ 0 recorrente:** Cloudflare Pages + Workers + D1, mas é um CRM NOVO e menor, não a versão original do DeskComm.

Nenhuma conta, VM, domínio, serviço pago, integração WhatsApp ou IA foi criado por este documento. Credenciais devem ser fornecidas exclusivamente nos painéis oficiais.
