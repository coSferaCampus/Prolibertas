class ReportsController < ApplicationController
  respond_to :json

  def genre
    @report = Report.genre
    respond_with @report.to_json
  end

  def spanish
    @report = Report.spanish
    respond_with @report.to_json
  end

  def documentation
    @report = Report.documentation
    respond_with @report.to_json
  end

  def assistance
    @report = Report.assistance
    respond_with @report.to_json
  end

  def residence
    @report = Report.residence
    respond_with @report.to_json
  end

end
