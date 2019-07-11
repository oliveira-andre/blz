module ReportSchedulingProblemsHelper
  def report_problem_category_collection
    category_collection = []
    ReportSchedulingProblem.categories.each do |category|
      category_collection << [I18n.t("activerecord.enums.report_problem_category.#{category.first}"),
                              category.first]
    end
    category_collection
  end
end
