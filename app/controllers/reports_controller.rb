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

  def age
    $year = params[:selected_year]

    name = "InformePorEdad"
    name += params[:selected_year] if params[:selected_year]

    data               = Report.age
    data_spanish       = data[ :spanish       ]
    data_spanish_man   = data[ :spanish_man   ]
    data_spanish_woman = data[ :spanish_woman ]
    data_foreign       = data[ :foreign       ]
    data_foreign_man   = data[ :foreign_man   ]
    data_foreign_woman = data[ :foreign_woman ]

    Spreadsheet.client_encoding = 'ISO8859-15'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => name

    sheet.row(0).concat ["", "18 a 30", "31 a 45", "46 a 55", "mas de 60"]

    sheet[1,0] = 'Españoles'.encode(Encoding::ISO_8859_1)
    sheet[2,0] = 'Españoles hombres'.encode(Encoding::ISO_8859_1)
    sheet[3,0] = 'Españoles mujeres'.encode(Encoding::ISO_8859_1)
    sheet[4,0] = 'Extranjeros'.encode(Encoding::ISO_8859_1)
    sheet[5,0] = 'Extranjeros hombres'.encode(Encoding::ISO_8859_1)
    sheet[6,0] = 'Extranjeros mujeres'.encode(Encoding::ISO_8859_1)

    row1 = sheet.row(1)
    row2 = sheet.row(2)
    row3 = sheet.row(3)
    row4 = sheet.row(4)
    row5 = sheet.row(5)
    row6 = sheet.row(6)

    data_spanish.each       { |data| row1.push data }
    data_spanish_man.each   { |data| row2.push data }
    data_spanish_woman.each { |data| row3.push data }
    data_foreign.each       { |data| row4.push data }
    data_foreign_man.each   { |data| row5.push data }
    data_foreign_woman.each { |data| row6.push data }

    spreadsheet = StringIO.new
    book.write spreadsheet

    send_data(
      spreadsheet.string,
      filename: name + ".xls",
      type: 'application/vnd.ms-excel; charset=ISO8859-15; header=present',
      :stream => false
    )
  end

  def city
    $year = params[:selected_year]

    name = "EspañolesPorProcedencia".encode(Encoding::ISO_8859_1)
    name += params[:selected_year] if params[:selected_year]

    data = Report.city
    cities  = data[ :cities  ]
    amount  = data[ :amount  ]
    percent = data[ :percent ]


    Spreadsheet.client_encoding = 'ISO8859-15'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => name

    sheet.row(0).concat %w{CIUDAD Numero_personas %total}

    cities.each_with_index do |city, i|
      sheet[i+1, 0] = city.encode(Encoding::ISO_8859_1)
      sheet.row(i+1).push(amount[i], percent[i].to_s + '%')
    end

    spreadsheet = StringIO.new
    book.write spreadsheet

    send_data(
      spreadsheet.string,
      filename: name + ".xls",
      type: 'application/vnd.ms-excel; charset=ISO8859-15; header=present',
      :stream => false
    )
  end

  def origin
    $year = params[:selected_year]

    name = "InformePorPais".encode(Encoding::ISO_8859_1)
    name += params[:selected_year] if params[:selected_year]

    data = Report.origin
    countries = data[ :countries ]
    amount    = data[ :amount    ]
    percent   = data[ :percent   ]


    Spreadsheet.client_encoding = 'ISO8859-15'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => name

    sheet.row(0).concat %w{PAIS Numero_personas %total}

    countries.each_with_index do |el, i|
      sheet[i+1, 0] = el.encode(Encoding::ISO_8859_1)
      sheet.row(i+1).push(amount[i], percent[i].to_s + '%')
    end

    spreadsheet = StringIO.new
    book.write spreadsheet

    send_data(
      spreadsheet.string,
      filename: name + ".xls",
      type: 'application/vnd.ms-excel; charset=ISO8859-15; header=present',
      :stream => false
    )
  end

  def services
    $year = params[:selected_year]

    name = "InformePorEdad"
    name += params[:selected_year] if params[:selected_year]

    data = Report.type
    data_spanish = data[ :spanish ]
    data_foreign = data[ :foreign ]

    Spreadsheet.client_encoding = 'ISO8859-15'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => name

    sheet.row(0).concat ["", "18 a 30", "31 a 45", "46 a 55", "mas de 60"]

    sheet[1,0] = 'ESP_Comedor'.encode(Encoding::ISO_8859_1)
    sheet[2,0] = 'ESP_Ropero'.encode(Encoding::ISO_8859_1)
    sheet[3,0] = 'ESP_Ducha'.encode(Encoding::ISO_8859_1)
    sheet[4,0] = 'ESP_Desayuno'.encode(Encoding::ISO_8859_1)

    sheet[5,0] = 'EXT_Comedor'.encode(Encoding::ISO_8859_1)
    sheet[6,0] = 'EXT_Ropero'.encode(Encoding::ISO_8859_1)
    sheet[7,0] = 'EXT_Ducha'.encode(Encoding::ISO_8859_1)
    sheet[8,0] = 'EXT_Desayuno'.encode(Encoding::ISO_8859_1)

    sheet[9, 0] = 'TOTAL_Comedor'.encode(Encoding::ISO_8859_1)
    sheet[10,0] = 'TOTAL_Ropero'.encode(Encoding::ISO_8859_1)
    sheet[11,0] = 'TOTAL_Ducha'.encode(Encoding::ISO_8859_1)
    sheet[12,0] = 'TOTAL_Desayuno'.encode(Encoding::ISO_8859_1)
    sheet[13,0] = 'TOTAL_Bocadillos'.encode(Encoding::ISO_8859_1)

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
