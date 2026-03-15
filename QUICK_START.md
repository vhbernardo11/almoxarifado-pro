# Quick Start - Deploy Permanente em 5 Minutos

## Opção 1: Deploy no Render.com (Recomendado - Gratuito)

### Passo 1: Acessar Render
1. Acesse [https://render.com](https://render.com)
2. Clique em "Sign up" e escolha "Continue with GitHub"
3. Autorize o acesso ao seu repositório `almoxarifado-pro`

### Passo 2: Criar Web Service
1. No dashboard do Render, clique em "New +" → "Web Service"
2. Selecione o repositório `vhbernardo11/almoxarifado-pro`
3. Configure:
   - **Name**: `almoxarifado-pro`
   - **Environment**: `Node`
   - **Region**: Selecione a mais próxima (ex: São Paulo)
   - **Build Command**: `cd server && pnpm install`
   - **Start Command**: `cd server && node index.js`
   - **Plan**: Free (gratuito)

### Passo 3: Deploy
Clique em "Create Web Service" e aguarde ~2-3 minutos

### Passo 4: Acessar o Site
Após o deploy, você receberá uma URL como:
```
https://almoxarifado-pro.onrender.com
```

---

## Opção 2: Deploy no Railway.app

### Passo 1: Acessar Railway
1. Acesse [https://railway.app](https://railway.app)
2. Clique em "Login with GitHub"
3. Autorize o acesso

### Passo 2: Criar Projeto
1. Clique em "New Project"
2. Selecione "Deploy from GitHub repo"
3. Escolha `almoxarifado-pro`

### Passo 3: Configurar
1. Clique em "Add Service" → "GitHub Repo"
2. Configure as variáveis de ambiente:
   - `PORT`: `3000`
   - `NODE_ENV`: `production`

### Passo 4: Deploy
O deploy será automático. Acesse a URL fornecida.

---

## Opção 3: Deploy no Vercel (Frontend) + Render (Backend)

### Frontend no Vercel
1. Acesse [https://vercel.com](https://vercel.com)
2. Clique em "Import Project"
3. Selecione `almoxarifado-pro`
4. Configure "Root Directory" como `.` (raiz)
5. Deploy

### Backend no Render
Siga os passos da Opção 1 acima.

---

## Verificar o Deploy

Após o deploy, acesse:
```
https://seu-dominio.onrender.com
```

Teste as funcionalidades:
1. ✅ Importar JSON de produtos
2. ✅ Visualizar estoque
3. ✅ Fazer transferências
4. ✅ Gerar relatórios
5. ✅ Exportar dados

---

## Troubleshooting Rápido

| Problema | Solução |
|----------|---------|
| Erro 502 | Aguarde 2-3 min para o deploy completar |
| Dados não salvam | Verifique se o backend está rodando |
| Página em branco | Limpe o cache (Ctrl+Shift+Del) |
| Erro de CORS | Já está configurado no backend |

---

## Próximas Etapas

1. **Compartilhar URL**: Envie o link para os usuários
2. **Backup**: Exporte dados regularmente via "Exportar JSON"
3. **Monitoramento**: Monitore no dashboard do Render/Railway
4. **Atualizações**: Faça push para `main` e o deploy será automático

---

**Dúvidas?** Consulte o arquivo `DEPLOY.md` para mais detalhes.
