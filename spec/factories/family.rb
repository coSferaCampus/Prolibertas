FactoryGirl.define do
  factory :family do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    origin { ["España","Marruecos","Rumanía","Afganistán","Islas Äland","Albania","Algeria","Samoa Americana","Andorra","Angola","Anguila","Antártida","Antigua y Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbayán","Bahamas","Bahrein","Bangladesh","Barbados","Bielorrusia","Bélgica","Belice","Benín","Islas Bermudas","Bhután","Bolivia, Estado plurinacional de","Islas BES (Caribe Neerlandés)","Bosnia y Herzegovina","Botsuana","Isla Bouvet","Brasil","Británico del Océano Índico, Territorio","Brunei Darussalam","Bulgaria","Burquina Faso","Burundi","Camboya","Camerún","Canadá","Cabo Verde","Islas Caimán","República Centro-africana","Chad","Chile","China","Isla de Navidad","Islas Cocos (Keeling)","Colombia","Comores, Islas","Congo","Islas Cook","Costa Rica","Costa de Marfíl","Croacia","Cuba","Curasao","Chipre","República Checa","Dinamarca","Yibuti","Dominica","República Dominicana","Ecuador","Egipto","El Salvador","Guinea Ecuatorial","Eritrea","Estonia","Etiopía","Islas Falkland (Malvinas)","Islas Feroe","Fiyi","Finlandia","Francia","Guayana Francesa","Polinesia Francesa","Territorios Franceses del Sur","Gabón","Gambia","Georgia","Alemania","Ghana","Gibraltar","Grecia","Groenlandia","Granada","Guadalupe","Guam","Guatemala","Guernsey","Guinea","Guinea-Bissau","Guyana","Haití","Islas Heard e Islas McDonald","Santa Sede (Ciudad Estado del Vaticano)","Honduras","Hong Kong","Hungría","Islandia","India","Indonesia","Irán, República islámica de","Irak","Irlanda","Isla de Man","Israel","Italia","Jamaica","Japón","Jersey","Jordania","Kazajistán","Kenia","Kiribati","Corea","Kuwait","Kirgizstán","Lao","Letonia","Líbano","Lesoto","Liberia","Libia","Liechtenstein","Lituania","Luxemburgo","Macao","Macedonia","Madagascar","Malawi","Malasia","Islas Maldivas","Mali","Malta","Islas Marshall","Martinica","Mauritania","Mauricio","Mayotte","México","Micronesia","Moldavia","Mónaco","Mongolia","Montenegro","Montserrat","Mozambique","Birmania","Namibia","Nauru","Nepal","Países Bajos","Nueva Caledonia","Nueva Zelanda","Nicaragua","Niger","Nigeria","Niue","Isla Norfolk","Islas Marianas del Norte","Noruega","Omán","Pakistán","Palau","Palestina","Panamá","Papúa Nueva Guinea","Paraguay","Perú","Filipinas","Pitcairn","Polonia","Portugal","Puerto Rico","Qatar","Reunión","Federación Rusa","Ruanda","San Bartolomé","Santa Elena, Ascensión y Tristán de Acuña","San Cristobo y Nevis","Santa Lucía","San Martín (zona francesa)","San Pedro y Miquelon","San Vicente y las Granadinas","Samoa","San Marino","Santo Tomé y Príncipe","Arabia Saudí","Senegal","Serbia","Seychelles","Sierra Leona","Singapur","Isla de San Martín (zona holandesa)","Eslovaquia","Eslovenia","Islas Salomón","Somalia","Suráfrica","Georgia del Sur e Islas Sandwitch del Sur","Sri Lanka","Sudán","Surinám","Sudán del Sur","Svalbard y Jan Mayen","Swazilandia","Suecia","Suiza","República árabe de Siria","Taiwán","Tadjikistán","Tanzania","Tailandia","Timor Oriental","Togo","Tokelau","Tonga","Trinidad y Tobago","Tunez","Turquía","Turkmenistán","Turks y Caicos, Islas","Tuvalu","Uganda","Ucrania","Emiratos Árabes Unidos","Reino Unido","Estados Unidos","Islas menores exteriores de Estados Unidos","Uruguay","Uzbekistán","Vanuatu","Venezuela, República Bolivariana de","Vietnam","Islas Vírgenes, Británicas","Islas Vírgenes, de EEUU","Wallis y Futuna","Sahara Occidental","Yemen","Zambia","Zimbabue"].sample }
    menu { ["standar", "muslim"].sample }
    phone { Faker::PhoneNumber.cell_phone }
    adults { rand(1...3) }
    children { rand(1...5) }
    birthchildren { "1,2,1" }
    socialworker { Faker::Name.name}
    type_of_income { [0, 1].sample }
    amount_of_income {  rand(100...700).to_f.to_s }
#    address_type { [0, 1, 2].sample }
    address { Faker::Address.street_address }
    assistance { [0, 1, 2].sample }
    id_type { ["NIF", "NIE", "Pasaporte", "Otro"].sample }
    identifier { Faker::Number.number(8) }
    from { Date.today }
    to { Date.tomorrow }
  end

  # Sólo se debe usar con attributes_for
  factory :family_update, parent: :family do
    name "Nombre nuevo"
    surname { Faker::Name.last_name }
    origin { ["España","Marruecos","Rumanía","Afganistán","Islas Äland","Albania","Algeria","Samoa Americana","Andorra","Angola","Anguila","Antártida","Antigua y Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbayán","Bahamas","Bahrein","Bangladesh","Barbados","Bielorrusia","Bélgica","Belice","Benín","Islas Bermudas","Bhután","Bolivia, Estado plurinacional de","Islas BES (Caribe Neerlandés)","Bosnia y Herzegovina","Botsuana","Isla Bouvet","Brasil","Británico del Océano Índico, Territorio","Brunei Darussalam","Bulgaria","Burquina Faso","Burundi","Camboya","Camerún","Canadá","Cabo Verde","Islas Caimán","República Centro-africana","Chad","Chile","China","Isla de Navidad","Islas Cocos (Keeling)","Colombia","Comores, Islas","Congo","Islas Cook","Costa Rica","Costa de Marfíl","Croacia","Cuba","Curasao","Chipre","República Checa","Dinamarca","Yibuti","Dominica","República Dominicana","Ecuador","Egipto","El Salvador","Guinea Ecuatorial","Eritrea","Estonia","Etiopía","Islas Falkland (Malvinas)","Islas Feroe","Fiyi","Finlandia","Francia","Guayana Francesa","Polinesia Francesa","Territorios Franceses del Sur","Gabón","Gambia","Georgia","Alemania","Ghana","Gibraltar","Grecia","Groenlandia","Granada","Guadalupe","Guam","Guatemala","Guernsey","Guinea","Guinea-Bissau","Guyana","Haití","Islas Heard e Islas McDonald","Santa Sede (Ciudad Estado del Vaticano)","Honduras","Hong Kong","Hungría","Islandia","India","Indonesia","Irán, República islámica de","Irak","Irlanda","Isla de Man","Israel","Italia","Jamaica","Japón","Jersey","Jordania","Kazajistán","Kenia","Kiribati","Corea","Kuwait","Kirgizstán","Lao","Letonia","Líbano","Lesoto","Liberia","Libia","Liechtenstein","Lituania","Luxemburgo","Macao","Macedonia","Madagascar","Malawi","Malasia","Islas Maldivas","Mali","Malta","Islas Marshall","Martinica","Mauritania","Mauricio","Mayotte","México","Micronesia","Moldavia","Mónaco","Mongolia","Montenegro","Montserrat","Mozambique","Birmania","Namibia","Nauru","Nepal","Países Bajos","Nueva Caledonia","Nueva Zelanda","Nicaragua","Niger","Nigeria","Niue","Isla Norfolk","Islas Marianas del Norte","Noruega","Omán","Pakistán","Palau","Palestina","Panamá","Papúa Nueva Guinea","Paraguay","Perú","Filipinas","Pitcairn","Polonia","Portugal","Puerto Rico","Qatar","Reunión","Federación Rusa","Ruanda","San Bartolomé","Santa Elena, Ascensión y Tristán de Acuña","San Cristobo y Nevis","Santa Lucía","San Martín (zona francesa)","San Pedro y Miquelon","San Vicente y las Granadinas","Samoa","San Marino","Santo Tomé y Príncipe","Arabia Saudí","Senegal","Serbia","Seychelles","Sierra Leona","Singapur","Isla de San Martín (zona holandesa)","Eslovaquia","Eslovenia","Islas Salomón","Somalia","Suráfrica","Georgia del Sur e Islas Sandwitch del Sur","Sri Lanka","Sudán","Surinám","Sudán del Sur","Svalbard y Jan Mayen","Swazilandia","Suecia","Suiza","República árabe de Siria","Taiwán","Tadjikistán","Tanzania","Tailandia","Timor Oriental","Togo","Tokelau","Tonga","Trinidad y Tobago","Tunez","Turquía","Turkmenistán","Turks y Caicos, Islas","Tuvalu","Uganda","Ucrania","Emiratos Árabes Unidos","Reino Unido","Estados Unidos","Islas menores exteriores de Estados Unidos","Uruguay","Uzbekistán","Vanuatu","Venezuela, República Bolivariana de","Vietnam","Islas Vírgenes, Británicas","Islas Vírgenes, de EEUU","Wallis y Futuna","Sahara Occidental","Yemen","Zambia","Zimbabue"].sample }
    menu { ["standar", "muslim"].sample }
    phone { Faker::PhoneNumber.cell_phone }
    adults { rand(1...3) }
    children { rand(1...5) }
    birthchildren "1,2,1"
    socialworker { Faker::Name.name}
    type_of_income { [0, 1].sample }
    amount_of_income {  rand(100...700).to_f.to_s }
#    address_type { [0, 1, 2].sample }
    address { Faker::Address.street_address }
    assistance { [0, 1, 2].sample }
    id_type { ["NIF", "NIE", "Pasaporte", "Otro"].sample }
    identifier { Faker::Number.number(8) }
    from { Date.today }
    to { Date.tomorrow }
  end
end
