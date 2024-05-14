#!/bin/sh
echo "digite o id para o cliente"
read id
curl http://127.0.0.1:4567/clientes/$id | jq