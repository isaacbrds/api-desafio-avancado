require 'mysql2'
require 'yaml'
require_relative '../entidades/cliente'

class ClienteServico
  def initialize
    conectar_mysql
  end

  def todos
    # Query to fetch all clients
    query = 'SELECT * FROM clientes'
    # Execute the query
    resultado = @mysql.query(query)
    clientes = []
    resultado.each do |linha|
      cliente = Cliente.new
      cliente.id = linha['id']
      cliente.nome = linha['nome']
      cliente.telefone = linha['telefone']
      cliente.observacao = linha['observacao']
      clientes << cliente
    end

    # Convert the result to an array of hashes
    clientes
  end

  private 

  def configuracoes
    ambiente = ENV["SINATRA_ENV"] || "development"
    
    @configuracao_conexao ||= YAML.safe_load(File.read('config/database.yml'), aliases: true)[ambiente]
  end

  def conectar_mysql
    # Establish MySQL connection
    @mysql = Mysql2::Client.new(
      host: configuracoes['host'],
      port: configuracoes['port'],
      username: configuracoes['username'],
      password: configuracoes['password'],
      database: configuracoes['database']
    )
  end
end
