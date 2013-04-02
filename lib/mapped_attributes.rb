require_relative "mapped_attributes/version"

module MappedAttributes
  def set_mapped_attributes(data, opts = {})
    @unused_data_fields = data.keys
    mapping = get_attributes_mapping(opts[:as] || self.class.name.underscore)
    self.attributes = get_mapped_attributes(data, mapping)
  end

  def get_unmapped_attributes
    @unused_data_fields || []
  end

  private
  def get_attributes_mapping(namespace)
    mapping = I18n.t(namespace, scope: 'activerecord.mappings')
    raise 'Mapping not defined in activerecord.mappings' unless mapping.is_a? Hash
    mapping
  end

  def get_mapped_attributes(data, mapping)
    mapping.inject({}) do |result, mapped_field|
      if mapped_field[1].is_a? Hash
        result[mapped_field[0]] = get_mapped_attributes(data, mapped_field[1])
      else
        labels = Array(mapped_field[1]).map(&:downcase)
        @unused_data_fields.delete_if{|field| labels.include?(field.downcase)}
        mapped_data = data.detect{|k,v| labels.include?(k.downcase)}
        result[mapped_field[0]] = mapped_data[1] if mapped_data
      end
      result
    end
  end
end