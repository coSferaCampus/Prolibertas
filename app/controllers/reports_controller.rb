class ReportsController < ApplicationController
  respond_to :json

  def genre
    @report = Report.genre
    puts "EL GENERO ES: #{@report}"
    respond_with @report.to_json
  end

  def spanish
    @report = Report.spanish
    puts "Españoles y Extranjeros: #{@report}"
    respond_with @report.to_json
  end
end
