#!/bin/bash
echo "Digite o id para ser deletado"
read id
curl -X DELETE -H 'Content-Type: application/json' http://localhost:4567/clientes/$id 
  
