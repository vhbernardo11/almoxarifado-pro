# Guia de Deploy Permanente - Almoxarifado Pro

## Opções de Hospedagem Recomendadas

### 1. **Render.com** (Recomendado - Gratuito com limite)
- Suporta Node.js nativamente
- Banco de dados PostgreSQL gratuito
- Deploy automático via GitHub
- Persistência de dados

### 2. **Vercel** (Frontend) + Render (Backend)
- Vercel para servir o frontend estático
- Render para o backend Node.js

### 3. **Railway.app**
- Suporta Node.js e PostgreSQL
- Deploy simples via GitHub
- Créditos gratuitos iniciais

## Deploy no Render.com

### Passo 1: Criar conta no Render
1. Acesse [render.com](https://render.com)
2. Faça login com sua conta GitHub
3. Autorize o acesso ao repositório `almoxarifado-pro`

### Passo 2: Criar um novo Web Service
1. Clique em "New +" → "Web Service"
2. Selecione o repositório `vhbernardo11/almoxarifado-pro`
3. Configure:
   - **Name**: `almoxarifado-pro`
   - **Environment**: `Node`
   - **Build Command**: `cd server && pnpm install`
   - **Start Command**: `cd server && node index.js`
   - **Port**: `3000`

### Passo 3: Configurar Variáveis de Ambiente
- `PORT`: `3000`
- `NODE_ENV`: `production`

### Passo 4: Deploy
O deploy será automático a cada push no branch `main`

## Estrutura de Dados Permanente

O sistema usa `lowdb` com persistência em arquivo JSON. Os dados são armazenados em:
```
/server/data/produtos_db.json
```

### Backup Automático
Para garantir que os dados não sejam perdidos:
1. Faça backup regular do arquivo `produtos_db.json`
2. Exporte os dados via "Exportar JSON" na interface

## URLs de Acesso

Após o deploy no Render:
- **Frontend**: `https://almoxarifado-pro.onrender.com`
- **API**: `https://almoxarifado-pro.onrender.com/api`

## Monitoramento

Monitore o status do serviço em:
- Render Dashboard: [render.com/dashboard](https://render.com/dashboard)
- Logs: Disponíveis no painel do Render em tempo real

## Troubleshooting

### Erro: "lowdb: missing default data"
**Solução**: Já foi corrigido no `server/index.js`. Se persistir, verifique se o arquivo `data/produtos_db.json` existe.

### Erro: "Port already in use"
**Solução**: O Render atribui a porta automaticamente. Verifique a variável `PORT` nas configurações.

### Dados não persistem
**Solução**: Verifique se o arquivo `data/produtos_db.json` tem permissões de escrita no servidor.

## Próximos Passos

1. Faça o deploy no Render
2. Teste todas as funcionalidades (importar, exportar, transferências)
3. Configure backups automáticos
4. Compartilhe a URL com os usuários

---

**Versão**: 1.0
**Última atualização**: 15/03/2026
