class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def t_status
    I18n.t("activerecord.enums.#{model_name.name.downcase}.#{status}")
  end
end
