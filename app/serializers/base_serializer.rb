class BaseSerializer
    include FastJsonapi::ObjectSerializer

    def self.display_value_or_default(value, default)
      value.present? ? value : default
    end
end
