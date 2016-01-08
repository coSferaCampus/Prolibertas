class ReportsController < ApplicationController
  respond_to :json
  require 'spreadsheet'

# def genre
#   $year = params[:selected_year]
#   @report = Report.genre
#   respond_with @report.to_json
# end
#
# def spanish
#   $year = params[:selected_year]
#   @report = Report.spanish
#   respond_with @report.to_json
# end
#
# def documentation
#   $year = params[:selected_year]
#   @report = Report.documentation
#   respond_with @report.to_json
# end
#
# def assistance
#   $year = params[:selected_year]
#   @report = Report.assistance
#   respond_with @report.to_json
# end
#
# def residence
#   $year = params[:selected_year]
#   @report = Report.residence
#   respond_with @report.to_json
# end
#
# def origin
#   $year = params[:selected_year]
#   @report = Report.origin
#   respond_with @report.to_json
# end
#
# def city
#   $year = params[:selected_year]
#   @report = Report.city
#   respond_with @report.to_json
# end
#
# def people
#   $year = params[:selected_year]
#   @report = Report.people
#   respond_with @report.to_json
# end
#
# def services_year
#   $year = params[:selected_year]
#   @report = Report.services_year
#   respond_with @report.to_json
# end
#
# def sandwiches
#   $year = params[:selected_year]
#   @report = Report.sandwiches
#   respond_with @report.to_json
# end
#
# def inv
#   $year = params[:selected_year]
#   @report = Report.inv
#   respond_with @report.to_json
# end
#
# def families
#   $year = params[:selected_year]
#   @report = Report.families
#   respond_with @report.to_json
# end

  def type
    $year = params[:selected_year]

    name = "InformePorTipo"
    name += params[:selected_year] if params[:selected_year]

    data = Report.type
    data_spanish = data[ :spanish ]
    data_foreign = data[ :foreign ]
    data_family  = data[ :family  ]

    Spreadsheet.client_encoding = 'ISO8859-15'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => name

    sheet.row(0).concat %w{TIPO Total Hombres Mujeres 1_Vez Habituales Reincidentes Indocumentados Regularizados Irregulares Residente De_Paso Serv_Social_Si Serv_Social_No Con_Ingresos Sin_Ingresos}

    sheet[1,0] = 'Españoles'.encode(Encoding::ISO_8859_1)
    sheet[2,0] = 'Extranjeros'.encode(Encoding::ISO_8859_1)
    sheet[3,0] = 'Familias'.encode(Encoding::ISO_8859_1)

    row1 = sheet.row(1)
    row2 = sheet.row(2)
    row3 = sheet.row(3)

    data_spanish.each { |data| row1.push data }
    data_foreign.each { |data| row2.push data }
    data_family.each  { |data| row3.push data }

    spreadsheet = StringIO.new
    book.write spreadsheet

    send_data(
      spreadsheet.string,
      filename: name + ".xls",
      type: 'application/vnd.ms-excel; charset=ISO8859-15; header=present',
      :stream => false
    )
  end
end
