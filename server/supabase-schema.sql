-- Execute este script no SQL Editor do Supabase

create extension if not exists pgcrypto;

create table if not exists public.produtos (
  id uuid primary key default gen_random_uuid(),
  codigo2 text unique not null,
  descricao text,
  unidade text,
  localizacao text,
  quantidade numeric(12,2) not null default 0,
  estoque_minimo numeric(12,2) not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

 drop trigger if exists trg_produtos_updated_at on public.produtos;
create trigger trg_produtos_updated_at
before update on public.produtos
for each row
execute function public.set_updated_at();

create index if not exists idx_produtos_codigo2 on public.produtos (codigo2);
create index if not exists idx_produtos_descricao on public.produtos (descricao);

alter table public.produtos enable row level security;

-- Ajuste as policies conforme sua necessidade.
-- Durante a fase inicial, você pode manter o acesso via backend usando a SERVICE_ROLE_KEY.

create policy "Leitura autenticada de produtos"
on public.produtos
for select
using (true);

create policy "Insercao autenticada de produtos"
on public.produtos
for insert
with check (true);

create policy "Atualizacao autenticada de produtos"
on public.produtos
for update
using (true);

create policy "Remocao autenticada de produtos"
on public.produtos
for delete
using (true);
