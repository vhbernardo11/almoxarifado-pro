-- Exclusivamente contatos e interações fictícios. Não contém telefones nem dados reais.
-- Repetível: ON CONFLICT evita duplicações.
BEGIN;
INSERT INTO deskcomm_demo.organizations(slug,display_name)
VALUES('oficina-exemplo-piloto','Oficina Exemplo (empresa ficticia)')
ON CONFLICT(slug) DO NOTHING;

INSERT INTO deskcomm_demo.contacts(organization_id,demo_key,display_name,category)
SELECT o.id,v.demo_key,v.name,'contato_ficticio'
FROM deskcomm_demo.organizations o
CROSS JOIN (VALUES
('DEMO-001','Cliente Ficticio 01'),('DEMO-002','Cliente Ficticio 02'),
('DEMO-003','Cliente Ficticio 03'),('DEMO-004','Cliente Ficticio 04'),
('DEMO-005','Cliente Ficticio 05')
) v(demo_key,name)
WHERE o.slug='oficina-exemplo-piloto'
ON CONFLICT(organization_id,demo_key) DO NOTHING;

INSERT INTO deskcomm_demo.opportunities(organization_id,contact_id,demo_key,title,stage,estimated_value_cents)
SELECT c.organization_id,c.id,v.demo_key,v.title,v.stage,v.cents
FROM deskcomm_demo.contacts c
JOIN (VALUES
('DEMO-001','ORC-001','Avaliacao de freios','novo',18000),
('DEMO-002','ORC-002','Troca de oleo','qualificacao',25000),
('DEMO-003','ORC-003','Revisao preventiva','orcamento',65000),
('DEMO-004','ORC-004','Servico de suspensao','negociacao',120000),
('DEMO-005','ORC-005','Revisao de viagem','ganho',43000)
) v(contact_key,demo_key,title,stage,cents) ON c.demo_key=v.contact_key
JOIN deskcomm_demo.organizations o ON o.id=c.organization_id
WHERE o.slug='oficina-exemplo-piloto'
ON CONFLICT(organization_id,demo_key) DO NOTHING;

INSERT INTO deskcomm_demo.conversation_samples(organization_id,contact_id,demo_key,direction,body)
SELECT c.organization_id,c.id,v.demo_key,v.direction,v.body
FROM deskcomm_demo.contacts c
JOIN (VALUES
('DEMO-001','MSG-001','entrada','Meu carro esta fazendo barulho ao frear. Voces fazem avaliacao?'),
('DEMO-001','MSG-002','saida_simulada','Fazemos avaliacao de freios. Posso encaminhar seu pedido para a equipe?'),
('DEMO-002','MSG-003','entrada','Gostaria de saber como funciona a troca de oleo.'),
('DEMO-003','MSG-004','entrada','Posso solicitar um orcamento para revisao preventiva?'),
('DEMO-004','MSG-005','entrada','Conseguem revisar a suspensao esta semana?'),
('DEMO-005','MSG-006','saida_simulada','Seu pedido de revisao esta registrado. A equipe confirmara o horario.')
) v(contact_key,demo_key,direction,body) ON c.demo_key=v.contact_key
JOIN deskcomm_demo.organizations o ON o.id=c.organization_id
WHERE o.slug='oficina-exemplo-piloto'
ON CONFLICT(organization_id,demo_key) DO NOTHING;

INSERT INTO deskcomm_demo.knowledge_samples(organization_id,demo_key,title,content)
SELECT o.id,v.demo_key,v.title,v.content
FROM deskcomm_demo.organizations o
CROSS JOIN (VALUES
('FAQ-001','Horario ficticio','Demonstracao: segunda a sexta das 08h as 18h. Nao e horario de empresa real.'),
('FAQ-002','Orcamentos','Os valores sao estimativas demonstrativas. Nenhum orcamento real deve ser gerado automaticamente.'),
('FAQ-003','Agendamento','O agente deve encaminhar a solicitacao para um atendente e nunca confirmar vagas sem calendario real.')
) v(demo_key,title,content)
WHERE o.slug='oficina-exemplo-piloto'
ON CONFLICT(organization_id,demo_key) DO NOTHING;
COMMIT;
