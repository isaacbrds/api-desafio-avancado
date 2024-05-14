require_relative '../servicos/clientes_servico'
require_relative '../servicos/obj_para_json_servico'

get '/clientes' do
    content_type :json # Set response content type to JSON
    clientes = ClienteServico.new.todos
    # require 'byebug'

    # debugger
    ObjParaJsonServico.transformar_para_json(clientes)
end