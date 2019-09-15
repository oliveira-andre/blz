module UsersDashboardHelper
  def scheduling_status
    Scheduling.statuses.map do |status|
      [I18n.t("activerecord.enums.scheduling.#{status.first}"),
        status.first]
    end
  end
end