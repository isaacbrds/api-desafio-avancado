class Entidade
    def to_hash
        instance_variables.each_with_object({}) do |var, hash|
          hash[var.to_s.delete('@').to_sym] = instance_variable_get(var)
        end
    end
end