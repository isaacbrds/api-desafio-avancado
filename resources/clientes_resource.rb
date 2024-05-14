require_relative '../servicos/clientes_servico'
require_relative '../servicos/obj_para_json_servico'
require_relative '../entidades/cliente'
require_relative '../servicos/erros/entidade_validacao_erro'

get '/clientes' do
    content_type :json # Set response content type to JSON
    pagina = request.params['pagina']
    clientes = ClienteServico.new.todos(pagina)
    # require 'byebug'

    # debugger
    ObjParaJsonServico.transformar_para_json(clientes)
end


post '/clientes' do
    content_type :json # Set response content type to JSON
    dados_cliente = JSON.parse(request.body.read)
    novo_cliente = Cliente.new
    novo_cliente.id = dados_cliente['id']
    novo_cliente.nome = dados_cliente['nome']
    novo_cliente.telefone = dados_cliente['telefone']
    novo_cliente.observacao = dados_cliente['observacao']
    
    begin 
      cliente = ClienteServico.new.salvar(novo_cliente)
      status 201
      cliente.to_hash.to_json
    rescue EntidadeValidacaoErro => e
      status 400
      { erro: e.message }.to_json
    end
    # require 'byebug'

    # debugger
end

delete '/clientes/:id' do
  content_type :json
  id = params[:id].to_i
  if id < 1
    status 400
    { erro: "O id é obrigatório" }.to_json
  else
    ClienteServico.new.excluir_por_id(id)
    status 204
    {}
  end
end

get '/clientes/:id' do
  content_type :json
  id = params[:id].to_i
  if id < 1
    status 400
    { erro: "O id é obrigatório" }.to_json
  else
    cliente = ClienteServico.new.buscar_por_id(id)
    status 200
    cliente_hash = cliente.to_hash
    cliente_hash.to_json 
  end
end