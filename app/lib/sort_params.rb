module SortParams
  DEFAULT_SORTING = { created_at: :desc }

  def self.sorted_fields(sort)
    return DEFAULT_SORTING if sort.blank?

    fields = sort.split(',')
    convert_to_ordered_hash(fields).map{|k,v| "#{k} #{v}"}.join(',')
  end

  def self.convert_to_ordered_hash(fields)
    fields.each_with_object({}) do |field, hash|
      if field.start_with?('-')
        field = field[1..-1]
        hash[field] = :desc
      else
        hash[field] = :asc
      end
    end
  end
end
