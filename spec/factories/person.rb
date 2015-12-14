FactoryGirl.define do

  factory :person do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    origin { ["España","Marruecos","Rumanía","Afganistán","Islas Äland","Albania","Algeria","Samoa Americana","Andorra","Angola","Anguila","Antártida","Antigua y Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbayán","Bahamas","Bahrein","Bangladesh","Barbados","Bielorrusia","Bélgica","Belice","Benín","Islas Bermudas","Bhután","Bolivia, Estado plurinacional de","Islas BES (Caribe Neerlandés)","Bosnia y Herzegovina","Botsuana","Isla Bouvet","Brasil","Británico del Océano Índico, Territorio","Brunei Darussalam","Bulgaria","Burquina Faso","Burundi","Camboya","Camerún","Canadá","Cabo Verde","Islas Caimán","República Centro-africana","Chad","Chile","China","Isla de Navidad","Islas Cocos (Keeling)","Colombia","Comores, Islas","Congo","Islas Cook","Costa Rica","Costa de Marfíl","Croacia","Cuba","Curasao","Chipre","República Checa","Dinamarca","Yibuti","Dominica","República Dominicana","Ecuador","Egipto","El Salvador","Guinea Ecuatorial","Eritrea","Estonia","Etiopía","Islas Falkland (Malvinas)","Islas Feroe","Fiyi","Finlandia","Francia","Guayana Francesa","Polinesia Francesa","Territorios Franceses del Sur","Gabón","Gambia","Georgia","Alemania","Ghana","Gibraltar","Grecia","Groenlandia","Granada","Guadalupe","Guam","Guatemala","Guernsey","Guinea","Guinea-Bissau","Guyana","Haití","Islas Heard e Islas McDonald","Santa Sede (Ciudad Estado del Vaticano)","Honduras","Hong Kong","Hungría","Islandia","India","Indonesia","Irán, República islámica de","Irak","Irlanda","Isla de Man","Israel","Italia","Jamaica","Japón","Jersey","Jordania","Kazajistán","Kenia","Kiribati","Corea","Kuwait","Kirgizstán","Lao","Letonia","Líbano","Lesoto","Liberia","Libia","Liechtenstein","Lituania","Luxemburgo","Macao","Macedonia","Madagascar","Malawi","Malasia","Islas Maldivas","Mali","Malta","Islas Marshall","Martinica","Mauritania","Mauricio","Mayotte","México","Micronesia","Moldavia","Mónaco","Mongolia","Montenegro","Montserrat","Mozambique","Birmania","Namibia","Nauru","Nepal","Países Bajos","Nueva Caledonia","Nueva Zelanda","Nicaragua","Niger","Nigeria","Niue","Isla Norfolk","Islas Marianas del Norte","Noruega","Omán","Pakistán","Palau","Palestina","Panamá","Papúa Nueva Guinea","Paraguay","Perú","Filipinas","Pitcairn","Polonia","Portugal","Puerto Rico","Qatar","Reunión","Federación Rusa","Ruanda","San Bartolomé","Santa Elena, Ascensión y Tristán de Acuña","San Cristobo y Nevis","Santa Lucía","San Martín (zona francesa)","San Pedro y Miquelon","San Vicente y las Granadinas","Samoa","San Marino","Santo Tomé y Príncipe","Arabia Saudí","Senegal","Serbia","Seychelles","Sierra Leona","Singapur","Isla de San Martín (zona holandesa)","Eslovaquia","Eslovenia","Islas Salomón","Somalia","Suráfrica","Georgia del Sur e Islas Sandwitch del Sur","Sri Lanka","Sudán","Surinám","Sudán del Sur","Svalbard y Jan Mayen","Swazilandia","Suecia","Suiza","República árabe de Siria","Taiwán","Tadjikistán","Tanzania","Tailandia","Timor Oriental","Togo","Tokelau","Tonga","Trinidad y Tobago","Tunez","Turquía","Turkmenistán","Turks y Caicos, Islas","Tuvalu","Uganda","Ucrania","Emiratos Árabes Unidos","Reino Unido","Estados Unidos","Islas menores exteriores de Estados Unidos","Uruguay","Uzbekistán","Vanuatu","Venezuela, República Bolivariana de","Vietnam","Islas Vírgenes, Británicas","Islas Vírgenes, de EEUU","Wallis y Futuna","Sahara Occidental","Yemen","Zambia","Zimbabue"].sample }
    genre { [:man, :woman].sample }
    phone { Faker::PhoneNumber.cell_phone }
    assistance { [0, 1, 2].sample }
    family_status { [:single, :married, :divorced, :widower].sample  }
    health_status {[:drug_addict, :alcoholic, :sic, :healthy].sample  }
    birth { Faker::Date.between(60.years.ago, 18.years.ago) }
    id_type { ["NIF", "NIE", "Pasaporte", "Otro"].sample }
    identifier { Faker::Number.number(8) }
    social_services { [0, 1].sample }
    menu { [:standar, :muslim].sample }
    income { [:yes, :not].sample }
    address { Faker::Address.street_address }
    contact_family { Faker::Name.first_name }
    notes { Faker::Lorem.paragraph}
    documentation { [0, 1, 2].sample }
    address_type { [0, 1, 2].sample }
    residence { [0, 1].sample }
    have_income { [0, 1].sample }
    city { [:Alava, :Albacete, :Alicante, :Almeria, :Asturias, :Avila, :Badajoz, :Baleares, :Barcelona,:Burgos, :Caceres, :Cadiz, :Cantabria, :Castellon, :Ceuta, :Ciudad_Real, :Cordoba, :Cuenca, :Girona, :Granada, :Guadalajara, :Guipuzcoa, :Huelva,:Huesca, :Jaen, :La_Coruna, :La_Rioja, :Las_Palmas, :Leon, :Lerida, :Lugo, :Madrid, :Malaga, :Melilla, :Murcia, :Navarra, :Orense, :Palencia, :Pontevedra,:Salamanca, :Segovia, :Sevilla, :Soria, :Tarragona, :Tenerife,:Teruel, :Toledo, :Valencia, :Valladolid, :Vizcaya, :Zamora, :Zaragoza].sample.to_s }
  end
  # Sólo se debe usar con attributes_for
  factory :person_update, parent: :person do
    name "A new name"
    surname "A new surname"
    origin { ["España","Marruecos","Rumanía","Afganistán","Islas Äland","Albania","Algeria","Samoa Americana","Andorra","Angola","Anguila","Antártida","Antigua y Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbayán","Bahamas","Bahrein","Bangladesh","Barbados","Bielorrusia","Bélgica","Belice","Benín","Islas Bermudas","Bhután","Bolivia, Estado plurinacional de","Islas BES (Caribe Neerlandés)","Bosnia y Herzegovina","Botsuana","Isla Bouvet","Brasil","Británico del Océano Índico, Territorio","Brunei Darussalam","Bulgaria","Burquina Faso","Burundi","Camboya","Camerún","Canadá","Cabo Verde","Islas Caimán","República Centro-africana","Chad","Chile","China","Isla de Navidad","Islas Cocos (Keeling)","Colombia","Comores, Islas","Congo","Islas Cook","Costa Rica","Costa de Marfíl","Croacia","Cuba","Curasao","Chipre","República Checa","Dinamarca","Yibuti","Dominica","República Dominicana","Ecuador","Egipto","El Salvador","Guinea Ecuatorial","Eritrea","Estonia","Etiopía","Islas Falkland (Malvinas)","Islas Feroe","Fiyi","Finlandia","Francia","Guayana Francesa","Polinesia Francesa","Territorios Franceses del Sur","Gabón","Gambia","Georgia","Alemania","Ghana","Gibraltar","Grecia","Groenlandia","Granada","Guadalupe","Guam","Guatemala","Guernsey","Guinea","Guinea-Bissau","Guyana","Haití","Islas Heard e Islas McDonald","Santa Sede (Ciudad Estado del Vaticano)","Honduras","Hong Kong","Hungría","Islandia","India","Indonesia","Irán, República islámica de","Irak","Irlanda","Isla de Man","Israel","Italia","Jamaica","Japón","Jersey","Jordania","Kazajistán","Kenia","Kiribati","Corea","Kuwait","Kirgizstán","Lao","Letonia","Líbano","Lesoto","Liberia","Libia","Liechtenstein","Lituania","Luxemburgo","Macao","Macedonia","Madagascar","Malawi","Malasia","Islas Maldivas","Mali","Malta","Islas Marshall","Martinica","Mauritania","Mauricio","Mayotte","México","Micronesia","Moldavia","Mónaco","Mongolia","Montenegro","Montserrat","Mozambique","Birmania","Namibia","Nauru","Nepal","Países Bajos","Nueva Caledonia","Nueva Zelanda","Nicaragua","Niger","Nigeria","Niue","Isla Norfolk","Islas Marianas del Norte","Noruega","Omán","Pakistán","Palau","Palestina","Panamá","Papúa Nueva Guinea","Paraguay","Perú","Filipinas","Pitcairn","Polonia","Portugal","Puerto Rico","Qatar","Reunión","Federación Rusa","Ruanda","San Bartolomé","Santa Elena, Ascensión y Tristán de Acuña","San Cristobo y Nevis","Santa Lucía","San Martín (zona francesa)","San Pedro y Miquelon","San Vicente y las Granadinas","Samoa","San Marino","Santo Tomé y Príncipe","Arabia Saudí","Senegal","Serbia","Seychelles","Sierra Leona","Singapur","Isla de San Martín (zona holandesa)","Eslovaquia","Eslovenia","Islas Salomón","Somalia","Suráfrica","Georgia del Sur e Islas Sandwitch del Sur","Sri Lanka","Sudán","Surinám","Sudán del Sur","Svalbard y Jan Mayen","Swazilandia","Suecia","Suiza","República árabe de Siria","Taiwán","Tadjikistán","Tanzania","Tailandia","Timor Oriental","Togo","Tokelau","Tonga","Trinidad y Tobago","Tunez","Turquía","Turkmenistán","Turks y Caicos, Islas","Tuvalu","Uganda","Ucrania","Emiratos Árabes Unidos","Reino Unido","Estados Unidos","Islas menores exteriores de Estados Unidos","Uruguay","Uzbekistán","Vanuatu","Venezuela, República Bolivariana de","Vietnam","Islas Vírgenes, Británicas","Islas Vírgenes, de EEUU","Wallis y Futuna","Sahara Occidental","Yemen","Zambia","Zimbabue"].sample }
    genre { [:man, :woman].sample }
    phone "A new phone"
    assistance { [0, 1, 2].sample }
    family_status "A new family_status"
    health_status "A new health_status"
    birth { Faker::Date.between(60.years.ago, 18.years.ago) }
    id_type { ["NIF", "NIE", "Pasaporte", "Otro"].sample }
    identifier { Faker::Number.number(8) }
    social_services { [0, 1].sample }
    menu "A new menu"
    income "A new income"
    address "A new address"
    contact_family "A new contact_family"
    notes "A new notes"
    documentation { [0, 1, 2].sample }
    address_type { [0, 1, 2].sample }
    residence { [0, 1].sample }
    have_income  { [0, 1].sample }
    city { [:Alava, :Albacete, :Alicante, :Almeria, :Asturias, :Avila, :Badajoz, :Baleares, :Barcelona,:Burgos, :Caceres, :Cadiz, :Cantabria, :Castellon, :Ceuta, :Ciudad_Real, :Cordoba, :Cuenca, :Girona, :Granada, :Guadalajara, :Guipuzcoa, :Huelva,:Huesca, :Jaen, :La_Coruna, :La_Rioja, :Las_Palmas, :Leon, :Lerida, :Lugo, :Madrid, :Malaga, :Melilla, :Murcia, :Navarra, :Orense, :Palencia, :Pontevedra,:Salamanca, :Segovia, :Sevilla, :Soria, :Tarragona, :Tenerife,:Teruel, :Toledo, :Valencia, :Valladolid, :Vizcaya, :Zamora, :Zaragoza].sample.to_s }
  end
end
