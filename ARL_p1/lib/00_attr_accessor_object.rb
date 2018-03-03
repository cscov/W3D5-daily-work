class AttrAccessorObject
  def self.my_attr_accessor(*attrs)
    attrs.each do |attr|
      define_method(attr) do
        instance_variable_get("@#{attr}".to_sym)
      end
      define_method("#{attr}=") do |other_attr|
        instance_variable_set("@#{attr}".to_sym, other_attr)
      end
    end
  end
end
