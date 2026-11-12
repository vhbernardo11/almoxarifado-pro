#!/usr/bin/env bash
# CHECK ONLY. Nao instala, baixa, inicia, conecta ou altera recursos.
set -uo pipefail

printf '\n=== DeskComm: preflight de VPS (somente leitura) ===\n'
printf 'Data UTC: '; date -u +'%Y-%m-%dT%H:%M:%SZ'
printf 'Arquitetura: '; uname -m
printf 'Sistema: '; (uname -s) 2>/dev/null || true

WARN=0
case "$(uname -m)" in
  x86_64|aarch64|arm64) printf '[OK] Arquitetura Linux compativel, sujeita a imagens oficiais.\n' ;;
  *) printf '[AVISO] Arquitetura deve ser revisada antes da instalacao.\n'; WARN=1 ;;
esac

if [ -r /proc/meminfo ]; then
  kb="$(awk '/^MemTotal:/ {print $2; exit}' /proc/meminfo)"
  if [[ "$kb" =~ ^[0-9]+$ ]]; then
    gib="$(awk -v x="$kb" 'BEGIN{printf "%.2f", x/1024/1024}')"
    printf 'RAM total: %s GiB\n' "$gib"
    if [ "$kb" -lt 3900000 ]; then printf '[AVISO] Menos de ~4 GiB de RAM; stack original pode ficar instavel.\n'; WARN=1; fi
  fi
else
  printf '[AVISO] Sem /proc/meminfo; conferir RAM manualmente.\n'
fi

if command -v nproc >/dev/null 2>&1; then
  cpu="$(nproc)"
  printf 'CPUs acessiveis: %s\n' "$cpu"
  if [ "$cpu" -lt 2 ]; then printf '[AVISO] Menos de 2 CPUs.\n'; WARN=1; fi
fi

if command -v df >/dev/null 2>&1; then
  printf 'Disco da particao atual (sem alterar dados):\n'
  df -h . | head -n 2
fi

if command -v docker >/dev/null 2>&1; then
  printf '[OK] Docker CLI: '; docker --version
  if docker compose version >/dev/null 2>&1; then
    printf '[OK] Docker Compose: '; docker compose version
  else
    printf '[AVISO] Docker Compose v2 nao encontrado.\n'; WARN=1
  fi
else
  printf '[AVISO] Docker nao encontrado. Nao sera instalado.\n'; WARN=1
fi

if command -v git >/dev/null 2>&1; then
  printf '[OK] Git: '; git --version
else
  printf '[AVISO] Git ausente; nao sera instalado.\n'; WARN=1
fi

printf '\nSeguranca: este script NAO le nem exibe secrets, nao roda curl, nao faz deploy.\n'
printf 'Proximo passo: revisar runbook, cotacao R$0 e esquema dedicado antes de instalar.\n'
if [ "$WARN" -ne 0 ]; then
  printf 'RESULTADO: requer verificacao de pre-requisitos (nenhuma alteracao feita).\n'
else
  printf 'RESULTADO: checagens basicas sem alertas, mas NAO e liberacao para producao.\n'
fi
