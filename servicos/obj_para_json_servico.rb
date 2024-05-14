class ObjParaJsonServico
  def self.transformar_para_json(lista)
    lista.map(&:to_hash).to_json
  end

  def self.transformar_para_obj(obj)
    obj.to_h.to_json
  end
end