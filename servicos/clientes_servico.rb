require 'mysql2'
require 'yaml'
require_relative '../entidades/cliente'

class ClienteServico
  def initialize
    conectar_mysql
  end

  def todos(pagina)
    pagina = 1 if pagina.to_i < 1
    limit = 5 
    offset = (pagina.to_i - 1) * limit

    # Query to fetch all clients
    query = "SELECT * FROM clientes limit #{limit} offset #{offset}"
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

  def salvar(cliente)
    raise EntidadeValidacaoErro.new("O nome tem que ser preenchido") if(cliente.nome.empty? || cliente.nome.nil?)

    if cliente.id.nil?
      # require 'byebug'
      # debugger
      query = "INSERT INTO clientes (nome, telefone, observacao, created_at, updated_at) VALUES (? , ?, ?, now(), now())"
      statement = @mysql.prepare(query)
      statement.execute(cliente.nome, cliente.telefone, cliente.observacao)
      cliente.id = statement.last_id
    else
      query = "UPDATE clientes SET nome = ?, telefone = ?, observacao = ? WHERE id = #{cliente.id}"
      statement = @mysql.prepare(query)
      statement.execute(cliente.nome, cliente.telefone, cliente.observacao)
    end

    cliente
  end

  def excluir_por_id(id)
    query = "DELETE FROM clientes WHERE id = #{id}"
    @mysql.query(query)
  end

  def buscar_por_id(id)
    query = "SELECT * FROM clientes WHERE id = #{id.to_i}"
    resultado = @mysql.query(query)
    resultado.each do |linha|
      @cliente = Cliente.new
      @cliente.id = linha['id']
      @cliente.nome = linha['nome']
      @cliente.telefone = linha['telefone']
      @cliente.observacao = linha['observacao']
    end
    @cliente
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
