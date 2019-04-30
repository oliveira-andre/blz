module UsersHelper
  def first_name(record)
    record.name.split(' ').first
  end
end
