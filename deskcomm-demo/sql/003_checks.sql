-- Verificações somente leitura, executar apenas em ambiente autorizado.
-- Consulta 1: contagens esperadas (1, 5, 5, 6, 3).
SELECT 'organizations' AS item,count(*)::int AS total FROM deskcomm_demo.organizations
UNION ALL SELECT 'contacts',count(*)::int FROM deskcomm_demo.contacts
UNION ALL SELECT 'opportunities',count(*)::int FROM deskcomm_demo.opportunities
UNION ALL SELECT 'conversation_samples',count(*)::int FROM deskcomm_demo.conversation_samples
UNION ALL SELECT 'knowledge_samples',count(*)::int FROM deskcomm_demo.knowledge_samples
ORDER BY item;

-- Consulta 2: todas as tabelas devem ter RLS ligado e forçado,
-- e nenhum dos papéis abaixo deve ter SELECT.
SELECT c.relname AS table_name,c.relrowsecurity AS rls_enabled,
 c.relforcerowsecurity AS rls_forced,
 has_table_privilege('anon',c.oid,'SELECT') AS anon_select,
 has_table_privilege('authenticated',c.oid,'SELECT') AS authenticated_select,
 has_table_privilege('service_role',c.oid,'SELECT') AS service_select
FROM pg_class c JOIN pg_namespace n ON c.relnamespace=n.oid
WHERE n.nspname='deskcomm_demo' AND c.relkind='r'
ORDER BY c.relname;

-- Consulta 3: acesso USAGE ao esquema não deve estar liberado.
SELECT has_schema_privilege('anon','deskcomm_demo','USAGE') AS anon_schema_usage,
 has_schema_privilege('authenticated','deskcomm_demo','USAGE') AS authenticated_schema_usage,
 has_schema_privilege('service_role','deskcomm_demo','USAGE') AS service_schema_usage;
