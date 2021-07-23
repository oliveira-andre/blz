# frozen_string_literal: true

module ReportSchedulingProblemsHelper
  def report_problem_category_collection
    ReportProblem.categories.map do |category|
      [I18n.t("activerecord.enums.report_problem_category.#{category.first}"),
       category.first]
    end
  end
end
