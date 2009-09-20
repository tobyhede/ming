class IdFactory
  def create_pk(row)
    return row if row[:_id]
    row.delete(:_id)      # in case it exists but the value is nil
    row['_id'] ||= Mongo::ObjectID.new().to_s
    row
  end
end