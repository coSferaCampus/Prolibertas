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

    sheet.row(0).concat ["", "18 a 30", "31 a 45", "46 a 60", "mas de 60"]

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

  def person_services
    $year = params[:selected_year]

    name = "ServiciosPorMeses"
    name += params[:selected_year] if params[:selected_year]

    data = Report.person_services

    data_esp_comedor      = data[ :esp_comedor      ]
    data_esp_ropero       = data[ :esp_ropero       ]
    data_esp_ducha        = data[ :esp_ducha        ]
    data_esp_desayuno     = data[ :esp_desayuno     ]

    data_ext_comedor      = data[ :ext_comedor      ]
    data_ext_ropero       = data[ :ext_ropero       ]
    data_ext_ducha        = data[ :ext_ducha        ]
    data_ext_desayuno     = data[ :ext_desayuno     ]

    data_total_comedor    = data[ :total_comedor    ]
    data_total_ropero     = data[ :total_ropero     ]
    data_total_ducha      = data[ :total_ducha      ]
    data_total_desayuno   = data[ :total_desayuno   ]
    data_total_bocadillos = data[ :total_bocadillos ]

    Spreadsheet.client_encoding = 'ISO8859-15'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => name

    sheet.row(0).concat ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio',
                         'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']

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

    row1  = sheet.row(1)
    row2  = sheet.row(2)
    row3  = sheet.row(3)
    row4  = sheet.row(4)
    row5  = sheet.row(5)
    row6  = sheet.row(6)
    row7  = sheet.row(7)
    row8  = sheet.row(8)
    row9  = sheet.row(9)
    row10 = sheet.row(10)
    row11 = sheet.row(11)
    row12 = sheet.row(12)
    row13 = sheet.row(13)

    data_esp_comedor.each      { |data| row1.push data  }
    data_esp_ropero.each       { |data| row2.push data  }
    data_esp_ducha.each        { |data| row3.push data  }
    data_esp_desayuno.each     { |data| row4.push data  }

    data_ext_comedor.each      { |data| row5.push data  }
    data_ext_ropero.each       { |data| row6.push data  }
    data_ext_ducha.each        { |data| row7.push data  }
    data_ext_desayuno.each     { |data| row8.push data  }

    data_total_comedor.each    { |data| row9.push data  }
    data_total_ropero.each     { |data| row10.push data }
    data_total_ducha.each      { |data| row11.push data }
    data_total_desayuno.each   { |data| row12.push data }
    data_total_bocadillos.each { |data| row13.push data }

    spreadsheet = StringIO.new
    book.write spreadsheet

    send_data(
      spreadsheet.string,
      filename: name + ".xls",
      type: 'application/vnd.ms-excel; charset=ISO8859-15; header=present',
      :stream => false
    )
  end

  def family_services
    $year = params[:selected_year]

    name = "ServiciosFamiliaPorMeses"
    name += params[:selected_year] if params[:selected_year]

    data = Report.family_services

    data_comedor = data[ :comedor ]
    data_ropero  = data[ :ropero  ]

    Spreadsheet.client_encoding = 'ISO8859-15'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => name

    sheet.row(0).concat ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio',
                         'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']

    sheet[1,0] = 'comedor'.encode(Encoding::ISO_8859_1)
    sheet[2,0] = 'ropero'.encode(Encoding::ISO_8859_1)

    row1 = sheet.row(1)
    row2 = sheet.row(2)

    data_comedor.each { |data| row1.push data }
    data_ropero.each  { |data| row2.push data }

    spreadsheet = StringIO.new
    book.write spreadsheet

    send_data(
      spreadsheet.string,
      filename: name + ".xls",
      type: 'application/vnd.ms-excel; charset=ISO8859-15; header=present',
      :stream => false
    )
  end

  def articles
    $year = params[:selected_year]

    name = "InventarioDeArticulos"
    name += params[:selected_year] if params[:selected_year]

    data = Report.articles
    amount = data[ :amount ]

    Spreadsheet.client_encoding = 'ISO8859-15'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => name

    sheet.row(0).concat ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio',
                         'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']

    articles = ["Mantas", "Sábanas", "Chaquetas", "Zapatos", "Canastillas"]

    articles.each_with_index do |el, i|
      sheet[i+1, 0] = el.encode(Encoding::ISO_8859_1)
      amount[i].each { |a|
        sheet.row(i+1).push(a) # Aqui meto los datos de cada fila
      }
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

  def family_zts
    $year = params[:selected_year]

    name = "FamiliasPorZTS"
    name += params[:selected_year] if params[:selected_year]

    data = Report.family_zts
    amount = data[ :amount ]

    Spreadsheet.client_encoding = 'ISO8859-15'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => name

    sheet.row(0).concat ['', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio',
                         'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']

    zonas = ["Norte-Sierra", "Levante", "Sureste (Fuensanta)", "Centro (La Ribera)", "Sur",
             "Poniente Sur", "Poniente Norte (La Foggara)", "Noroeste", "Periferia-Alcolea",
             "Periferia-Villarrubia", "Periferia-Santa Cruz", "Periferia-Cerro Muriano",
             "Periferia-El Higuerón", "Periferia-Trassierra", "ETF 1", "ETF 2", "ETF 3", "ETF 4"]

    zonas.each_with_index do |el, i|
      sheet[i+1, 0] = el.encode(Encoding::ISO_8859_1)
      amount[i].each { |a|
        sheet.row(i+1).push(a) # Aqui meto los datos de cada fila
      }
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
end
