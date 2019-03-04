module FiltersHelper
  def category?(key)
    key == 'category_id'
  end

  def category_name(value)
    Category.find(value).name
  end
end
