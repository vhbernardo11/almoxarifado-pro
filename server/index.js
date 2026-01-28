// index.js
// Node + Express + Socket.IO + lowdb (JSON file DB)
const path = require('path');
const fs = require('fs');
const express = require('express');
const http = require('http');
const cors = require('cors');
const bodyParser = require('body-parser');
const { Server } = require('socket.io');
const { Low } = require('lowdb');
const { JSONFile } = require('lowdb/node');

const PORT = process.env.PORT || 3000;
const DATA_DIR = path.join(__dirname, 'data');
const DB_FILE = path.join(DATA_DIR, 'produtos_db.json');

if (!fs.existsSync(DATA_DIR)) fs.mkdirSync(DATA_DIR, { recursive: true });
const adapter = new JSONFile(DB_FILE);
const db = new Low(adapter);

async function ensureDB() {
  await db.read();
  db.data = db.data || { produtos: [] };
  await db.write();
}

(async () => {
  await ensureDB();

  const app = express();
  const server = http.createServer(app);
  const io = new Server(server, {
    cors: { origin: process.env.CLIENT_ORIGIN || '*', methods: ['GET','POST','PUT','DELETE'] }
  });

  app.use(cors({ origin: process.env.CLIENT_ORIGIN || '*' }));
  app.use(bodyParser.json({ limit: '10mb' }));

  app.get('/api/health', (req, res) => res.json({ ok: true }));

  app.get('/api/produtos', async (req, res) => {
    await db.read();
    res.json(db.data.produtos || []);
  });

  app.post('/api/produtos', async (req, res) => {
    const novo = req.body;
    await db.read();
    db.data.produtos = db.data.produtos || [];
    db.data.produtos.push(novo);
    await db.write();
    io.emit('produtos:update', db.data.produtos);
    res.status(201).json(novo);
  });

  app.put('/api/produtos/:codigo2', async (req, res) => {
    const codigo2 = req.params.codigo2;
    const body = req.body;
    await db.read();
    db.data.produtos = db.data.produtos || [];
    const idx = db.data.produtos.findIndex(p => String(p.codigo2) === String(codigo2));
    if (idx === -1) return res.status(404).json({ error: 'Produto não encontrado' });
    db.data.produtos[idx] = { ...db.data.produtos[idx], ...body };
    await db.write();
    io.emit('produtos:update', db.data.produtos);
    res.json(db.data.produtos[idx]);
  });

  app.delete('/api/produtos/:codigo2', async (req, res) => {
    const codigo2 = req.params.codigo2;
    await db.read();
    db.data.produtos = db.data.produtos || [];
    const before = db.data.produtos.length;
    db.data.produtos = db.data.produtos.filter(p => String(p.codigo2) !== String(codigo2));
    await db.write();
    io.emit('produtos:update', db.data.produtos);
    res.json({ removed: before - db.data.produtos.length });
  });

  app.put('/api/produtos', async (req, res) => {
    const list = req.body;
    if (!Array.isArray(list)) return res.status(400).json({ error: 'Array esperado' });
    await db.read();
    db.data.produtos = list;
    await db.write();
    io.emit('produtos:update', db.data.produtos);
    res.json({ ok: true, total: db.data.produtos.length });
  });

  const PUBLIC_DIR = path.join(__dirname, 'public');
  if (fs.existsSync(PUBLIC_DIR)) app.use(express.static(PUBLIC_DIR));

  io.on('connection', socket => {
    socket.on('request:produtos', async () => { await db.read(); socket.emit('produtos:update', db.data.produtos || []); });
    socket.on('disconnect', () => {});
  });

  server.listen(PORT, () => console.log(`Server listening on port ${PORT}`));
})();
