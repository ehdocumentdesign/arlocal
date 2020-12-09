module InactiveRecordSingleton


  def all
    records = []
    self.inactive_records.each do |record|
      records << new(record)
    end
    records
  end


  def all_order_by_description
    records = []
    self.inactive_records_ordered_by_description.each do |record|
      records << new(record)
    end
    records
  end


  def find(key)
    case key
    when Integer
      self.find_by_id(key)
    when String
      self.find_by_id(key)
    when Symbol
      self.find_by_symbol(key)
    end
  end


  def find_by_id(id)
    record = self.inactive_records.select { |record| record[:id] == id.to_i }[0]
    if record
      self.new(record)
    else
      false
    end
  end


  def find_by_symbol(symbol)
    record = self.inactive_records.select { |record| record[:symbol] == symbol }[0]
    if record
      self.new(record)
    else
      false
    end
  end


  def find_id_from_param(param)
    symbol = param.to_sym
    self.find_by_symbol(symbol).id
  end


  def inactive_records
    self::DATA
  end


  def inactive_records_ordered_by_description
    self.inactive_records.sort_by { |record| record[:description] }
  end


  def inactive_records_ordered_by_id
    self.inactive_records.sort_by { |record| record[:id] }
  end


  def inactive_records_ordered_by_symbol
    self.inactive_records.sort_by { |record| record[:symbol] }
  end


  def options_for_select(attribute = :id)
    case attribute
    when :id
      options_for_select_id
    when :url
      options_for_select_url
    end
  end


  def options_for_select_id
    self.all_order_by_description.map { |record| [record.description, record.id] }
  end


  def options_for_select_url
    self.all_order_by_description.map { |record| [record.description, record.id, {data: {url: record.url}}] }
  end


end
