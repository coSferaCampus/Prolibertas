class ReportsController < ApplicationController
  respond_to :json

  def genre
    $year = params[:selected_year]
    @report = Report.genre
    respond_with @report.to_json
  end

  def spanish
    $year = params[:selected_year]
    @report = Report.spanish
    respond_with @report.to_json
  end

  def documentation
    $year = params[:selected_year]
    @report = Report.documentation
    respond_with @report.to_json
  end

  def assistance
    $year = params[:selected_year]
    @report = Report.assistance
    respond_with @report.to_json
  end

  def residence
    $year = params[:selected_year]
    @report = Report.residence
    respond_with @report.to_json
  end

  def origin
    $year = params[:selected_year]
    @report = Report.origin
    respond_with @report.to_json
  end

  def city
    $year = params[:selected_year]
    @report = Report.city
    respond_with @report.to_json
  end

  def people
    $year = params[:selected_year]
    @report = Report.people
    respond_with @report.to_json
  end

  def services_year
    $year = params[:selected_year]
    @report = Report.services_year
    respond_with @report.to_json
  end

  def sandwiches
    $year = params[:selected_year]
    @report = Report.sandwiches
    respond_with @report.to_json
  end

  def  inv
    $year = params[:selected_year]
    @report = Report.inv
    respond_with @report.to_json
  end

  def  families
    $year = params[:selected_year]
    @report = Report.families
    respond_with @report.to_json
  end
end
