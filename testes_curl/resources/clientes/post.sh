curl -X POST \
  http://localhost:4567/clientes \
  -H 'Content-Type: application/json' \
  -d '{
    "nome": "Cliente via curl",
    "telefone": "(88) 92345-6789",
    "observacao": "cliente VIP"
  }'
