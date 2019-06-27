module UsersHelper
  def first_name(record)
    record.name.split(' ').first
  end

  def profile(user)
    t("activerecord.enums.user.#{user.profile}")
  end
end
