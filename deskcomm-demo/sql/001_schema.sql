-- DeskComm CRM: protótipo de laboratório isolado, SEM criar tabelas em public.
-- Aplicado inicialmente no Supabase Fio Cliente em 12/11/2026.
-- Não é a migration nem o baseline.sql do DeskComm original.
-- NUNCA executar contra produção do DeskComm; todas as operações são de laboratório.
BEGIN;
CREATE SCHEMA IF NOT EXISTS deskcomm_demo;
REVOKE ALL ON SCHEMA deskcomm_demo FROM PUBLIC, anon, authenticated, service_role;

CREATE TABLE IF NOT EXISTS deskcomm_demo.organizations(
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text NOT NULL UNIQUE CHECK(length(slug) BETWEEN 3 AND 80),
  display_name text NOT NULL,
  is_demo boolean NOT NULL DEFAULT true CHECK(is_demo),
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS deskcomm_demo.contacts(
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES deskcomm_demo.organizations(id),
  demo_key text NOT NULL,
  display_name text NOT NULL,
  category text NOT NULL DEFAULT 'potencial_cliente',
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(organization_id,demo_key), UNIQUE(id,organization_id)
);
CREATE TABLE IF NOT EXISTS deskcomm_demo.opportunities(
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES deskcomm_demo.organizations(id),
  contact_id uuid NOT NULL,
  demo_key text NOT NULL,
  title text NOT NULL,
  stage text NOT NULL CHECK(stage IN ('novo','qualificacao','orcamento','negociacao','ganho','perdido')),
  estimated_value_cents integer NOT NULL DEFAULT 0 CHECK(estimated_value_cents>=0),
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(organization_id,demo_key),
  FOREIGN KEY(contact_id,organization_id) REFERENCES deskcomm_demo.contacts(id,organization_id)
);
CREATE TABLE IF NOT EXISTS deskcomm_demo.conversation_samples(
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES deskcomm_demo.organizations(id),
  contact_id uuid NOT NULL,
  demo_key text NOT NULL,
  direction text NOT NULL CHECK(direction IN ('entrada','saida_simulada')),
  body text NOT NULL,
  simulated boolean NOT NULL DEFAULT true CHECK(simulated),
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(organization_id,demo_key),
  FOREIGN KEY(contact_id,organization_id) REFERENCES deskcomm_demo.contacts(id,organization_id)
);
CREATE TABLE IF NOT EXISTS deskcomm_demo.knowledge_samples(
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES deskcomm_demo.organizations(id),
  demo_key text NOT NULL,
  title text NOT NULL,
  content text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(organization_id,demo_key)
);

ALTER TABLE deskcomm_demo.organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE deskcomm_demo.contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE deskcomm_demo.opportunities ENABLE ROW LEVEL SECURITY;
ALTER TABLE deskcomm_demo.conversation_samples ENABLE ROW LEVEL SECURITY;
ALTER TABLE deskcomm_demo.knowledge_samples ENABLE ROW LEVEL SECURITY;
ALTER TABLE deskcomm_demo.organizations FORCE ROW LEVEL SECURITY;
ALTER TABLE deskcomm_demo.contacts FORCE ROW LEVEL SECURITY;
ALTER TABLE deskcomm_demo.opportunities FORCE ROW LEVEL SECURITY;
ALTER TABLE deskcomm_demo.conversation_samples FORCE ROW LEVEL SECURITY;
ALTER TABLE deskcomm_demo.knowledge_samples FORCE ROW LEVEL SECURITY;

REVOKE ALL ON ALL TABLES IN SCHEMA deskcomm_demo FROM PUBLIC, anon, authenticated, service_role;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA deskcomm_demo FROM PUBLIC, anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA deskcomm_demo REVOKE ALL ON TABLES FROM PUBLIC, anon, authenticated, service_role;
COMMENT ON SCHEMA deskcomm_demo IS 'Somente prototipo isolado do DeskComm; dados ficticios, sem canal ou API publica.';
COMMIT;
