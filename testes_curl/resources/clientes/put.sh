#!/bin/sh
echo "Digite o id do cliente que deseja alterar"
read id

echo "Digite o novo nome do cliente"
read nome

echo "Digite o novo telefone do cliente"
read telefone

echo "Digite o novo observação do cliente"
read observacao


curl -X PUT \
  http://localhost:4567/clientes/$id \
  -H 'Content-Type: application/json' \
  -d "{
    \"nome\": \"$nome\",
    \"telefone\": \"$telefone\",
    \"observacao\": \"$observacao\"
  }"
