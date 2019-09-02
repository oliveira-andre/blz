module FiltersHelper
  def category?(key)
    key == 'category_id'
  end

  def category_name(value)
    Category.find_by(id: value)&.name
  end

  def local_type_collection
    [
      { name: 'A domicílio', value: :home },
      { name: 'No estabelecimento', value: :establishment }
    ].collect do |local_type|
      [local_type[:name], local_type[:value]]
    end
  end

  def price_collection
    [['Menor preço', 0], ['Maior preço', 1]]
  end
end
