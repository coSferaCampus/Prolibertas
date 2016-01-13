class Report
  def self.type
    people     = []
    person_ids = []
    family_ids = []
    spanish    = []
    foreign    = []
    family     = []

    UsedService.where(:created_at.gte => Date.new($year.to_i),
      :created_at.lt => Date.new($year.to_i + 1)
    ).each do |s|
      person_ids << s.person_id.to_s if s.person_id
      family_ids << s.family_id.to_s if s.family_id
    end

    person_ids.uniq!
    family_ids.uniq!

    people   = Person.where(:id.in => person_ids)
    families = Family.where(:id.in => family_ids)

    spanish_all = people.where(origin: 'España')
    foreign_all = people.where(:origin.ne => 'España')

    spanish << spanish_all.size
    spanish << spanish_all.where(genre: :man).size
    spanish << spanish_all.where(genre: :woman).size
    spanish << spanish_all.where(assistance: 0).size
    spanish << spanish_all.where(assistance: 1).size
    spanish << spanish_all.where(assistance: 2).size
    spanish << spanish_all.where(documentation: 0).size
    spanish << spanish_all.where(documentation: 1).size
    spanish << spanish_all.where(documentation: 2).size
    spanish << spanish_all.where(residence: 1).size
    spanish << spanish_all.where(residence: 0).size
    spanish << spanish_all.where(social_services: 1).size
    spanish << spanish_all.where(social_services: 0).size
    spanish << spanish_all.where(have_income: 1).size
    spanish << spanish_all.where(have_income: 0).size

    foreign << foreign_all.size
    foreign << foreign_all.where(genre: :man).size
    foreign << foreign_all.where(genre: :woman).size
    foreign << foreign_all.where(assistance: 0).size
    foreign << foreign_all.where(assistance: 1).size
    foreign << foreign_all.where(assistance: 2).size
    foreign << foreign_all.where(documentation: 0).size
    foreign << foreign_all.where(documentation: 1).size
    foreign << foreign_all.where(documentation: 2).size
    foreign << foreign_all.where(residence: 1).size
    foreign << foreign_all.where(residence: 0).size
    foreign << foreign_all.where(social_services: 1).size
    foreign << foreign_all.where(social_services: 0).size
    foreign << foreign_all.where(have_income: 1).size
    foreign << foreign_all.where(have_income: 0).size

    family << families.size

    { spanish: spanish, foreign: foreign, family: family }
  end
  def self.age
    people        = []
    person_ids    = []
    spanish       = []
    spanish_man   = []
    spanish_woman = []
    foreign       = []
    foreign_man   = []
    foreign_woman = []

    UsedService.where(:created_at.gte => Date.new($year.to_i),
      :created_at.lt => Date.new($year.to_i + 1)
    ).each { |s| person_ids << s.person_id.to_s if s.person_id }

    person_ids.uniq!

    people = Person.where(:id.in => person_ids)

    spanish_all = people.where(origin: 'España')
    spanish_all_man = spanish_all.where(genre: :man)
    spanish_all_woman = spanish_all.where(genre: :woman)

    foreign_all = people.where(:origin.ne => 'España')
    foreign_all_man = foreign_all.where(genre: :man)
    foreign_all_woman = foreign_all.where(genre: :woman)

    spanish << spanish_all.where(:birth.gte => 30.years.ago).size
    spanish << spanish_all.where(:birth.gte => 45.years.ago, :birth.lte => 31.years.ago).size
    spanish << spanish_all.where(:birth.gte => 59.years.ago, :birth.lte => 46.years.ago).size
    spanish << spanish_all.where(:birth.lte => 60.years.ago).size

    spanish_man << spanish_all_man.where(:birth.gte => 30.years.ago).size
    spanish_man << spanish_all_man.where(:birth.gte => 45.years.ago, :birth.lte => 31.years.ago).size
    spanish_man << spanish_all_man.where(:birth.gte => 59.years.ago, :birth.lte => 46.years.ago).size
    spanish_man << spanish_all_man.where(:birth.lte => 60.years.ago).size

    spanish_woman << spanish_all_woman.where(:birth.gte => 30.years.ago).size
    spanish_woman << spanish_all_woman.where(:birth.gte => 45.years.ago, :birth.lte => 31.years.ago).size
    spanish_woman << spanish_all_woman.where(:birth.gte => 59.years.ago, :birth.lte => 46.years.ago).size
    spanish_woman << spanish_all_woman.where(:birth.lte => 60.years.ago).size

    foreign << foreign_all.where(:birth.gte => 30.years.ago).size
    foreign << foreign_all.where(:birth.gte => 45.years.ago, :birth.lte => 31.years.ago).size
    foreign << foreign_all.where(:birth.gte => 59.years.ago, :birth.lte => 46.years.ago).size
    foreign << foreign_all.where(:birth.lte => 60.years.ago).size

    foreign_man << foreign_all_man.where(:birth.gte => 30.years.ago).size
    foreign_man << foreign_all_man.where(:birth.gte => 45.years.ago, :birth.lte => 31.years.ago).size
    foreign_man << foreign_all_man.where(:birth.gte => 59.years.ago, :birth.lte => 46.years.ago).size
    foreign_man << foreign_all_man.where(:birth.lte => 60.years.ago).size

    foreign_woman << foreign_all_woman.where(:birth.gte => 30.years.ago).size
    foreign_woman << foreign_all_woman.where(:birth.gte => 45.years.ago, :birth.lte => 31.years.ago).size
    foreign_woman << foreign_all_woman.where(:birth.gte => 59.years.ago, :birth.lte => 46.years.ago).size
    foreign_woman << foreign_all_woman.where(:birth.lte => 60.years.ago).size


    { spanish: spanish, spanish_man: spanish_man, spanish_woman: spanish_woman,
      foreign: foreign, foreign_man: foreign_man, foreign_woman: foreign_woman }
  end

  def self.city
    all = []
    percent = []
    person_ids = []

    UsedService.where(:created_at.gte => Date.new($year.to_i),
      :created_at.lt => Date.new($year.to_i + 1)
    ).each { |s| person_ids << s.person_id.to_s if s.person_id }

    person_ids.uniq!

    Person.where(:id.in => person_ids).each { |p| all << p.city if p.city }

    all_hash = all.inject(Hash.new(0)) { |h, e| h[e] += 1; h
    }.inject({}) { |r, e| r[e.first] = e.last; r
    }.sort_by { |k, v| -v }.to_h

    cities = all_hash.keys
    amount = all_hash.values
    total_amount = amount.inject(:+)

    amount.each { |a| percent << (a / total_amount.to_f * 100).round(2) }

    { cities: cities, amount: amount, percent: percent }
  end

  def self.origin
    all = []
    percent = []
    person_ids = []

    UsedService.where(:created_at.gte => Date.new($year.to_i),
      :created_at.lt => Date.new($year.to_i + 1)
    ).each { |s| person_ids << s.person_id.to_s if s.person_id }

    person_ids.uniq!

    Person.where(:id.in => person_ids).each { |p| all << p.origin if p.origin }

    all_hash = all.inject(Hash.new(0)) { |h, e| h[e] += 1; h
    }.inject({}) { |r, e| r[e.first] = e.last; r
    }.sort_by { |k, v| -v }.to_h

    countries = all_hash.keys
    amount = all_hash.values
    total_amount = amount.inject(:+)

    amount.each { |a| percent << (a / total_amount.to_f * 100).round(2) }

    { countries: countries, amount: amount, percent: percent }
  end

  def self.person_services
    esp_comedor      = []
    esp_ropero       = []
    esp_ducha        = []
    esp_desayuno     = []
    ext_comedor      = []
    ext_ropero       = []
    ext_ducha        = []
    ext_desayuno     = []
    total_comedor    = []
    total_ropero     = []
    total_ducha      = []
    total_desayuno   = []
    total_bocadillos = []
    person_ids = []

    vars = [esp_comedor, esp_ropero, esp_ducha, esp_desayuno, ext_comedor, ext_ropero, ext_ducha,
    ext_desayuno, total_comedor, total_ropero, total_ducha, total_desayuno, total_bocadillos]

    vars.map do |var|

    UsedService.where(:created_at.gte => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1))

    person_ids.uniq!

    { esp_comedor: esp_comedor, esp_ropero: esp_ropero, esp_ducha: esp_ducha,
      esp_desayuno: esp_desayuno, ext_comedor: ext_comedor, ext_ropero: ext_ropero,
      ext_ducha: ext_ducha, ext_desayuno: ext_desayuno, total_comedor: total_comedor,
      total_ropero: total_ropero, total_ducha: total_ducha, total_desayuno: total_desayuno,
      total_bocadillos: total_bocadillos }
  end

# def self.genre
#   man_amount   = Person.where(genre: 'man', :created_at.gt => Date.new($year.to_i),
#                               :created_at.lt => Date.new($year.to_i + 1)).size
#
#   woman_amount = Person.where(genre: 'woman', :created_at.gt => Date.new($year.to_i),
#                               :created_at.lt => Date.new($year.to_i + 1)).size
#
#   response = [{label: 'Hombres', amount: man_amount}, {label: 'Mujeres', amount: woman_amount}]
#
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response
# end
#
# def self.spanish
#   spanish_amount = Person.where(:origin.in => ['españa','España', 'ESPAÑA'],
#                                 :created_at.gt => Date.new($year.to_i),
#                                 :created_at.lt => Date.new($year.to_i + 1)).size
#
#   foreign_amount = Person.where(:created_at.gt => Date.new($year.to_i),
#                                 :created_at.lt => Date.new($year.to_i + 1)).size - spanish_amount
#
#   response = [{label: 'Extranjeros', amount: foreign_amount}, {label: 'Españoles', amount: spanish_amount}]
#
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response
# end
#
# def self.documentation
#   indocumentados = Person.where(documentation: 0, :created_at.gt => Date.new($year.to_i),
#                                 :created_at.lt => Date.new($year.to_i + 1)).size
#
#   regularizados  = Person.where(documentation: 1, :created_at.gt => Date.new($year.to_i),
#                                 :created_at.lt => Date.new($year.to_i + 1)).size
#
#   irregulares    = Person.where(documentation: 2, :created_at.gt => Date.new($year.to_i),
#                                 :created_at.lt => Date.new($year.to_i + 1)).size
#
#   response = [{label: 'Indocumentados', amount: indocumentados},
#               {label: 'Regularizados', amount: regularizados},
#               {label: 'Sin Regularizar', amount: irregulares}]
#
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response
# end
#
# def self.assistance
#   primera_vez = Person.where(assistance: 0, :created_at.gt => Date.new($year.to_i),
#                              :created_at.lt => Date.new($year.to_i + 1)).size
#
#   habitual    = Person.where(assistance: 1, :created_at.gt => Date.new($year.to_i),
#                              :created_at.lt => Date.new($year.to_i + 1)).size
#
#   reincidente = Person.where(assistance: 2, :created_at.gt => Date.new($year.to_i),
#                              :created_at.lt => Date.new($year.to_i + 1)).size
#
#   response = [{label: 'Primera vez', amount: primera_vez},
#               {label: 'Habitual', amount: habitual},
#               {label: 'Reincidente', amount: reincidente}]
#
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response
# end
#
# def self.residence
#   de_paso   = Person.where(residence: 0, :created_at.gt => Date.new($year.to_i),
#                            :created_at.lt => Date.new($year.to_i + 1)).size
#
#   residente = Person.where(residence: 1, :created_at.gt => Date.new($year.to_i),
#                            :created_at.lt => Date.new($year.to_i + 1)).size
#
#   response  = [{label: 'De Paso', amount: de_paso}, {label: 'Residente', amount: residente}]
#
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response
# end

# def self.origin
#   labels   = []
#   amounts  = []
#   response = []
#
#   Person.each { |x| labels << x.origin }
#   labels.uniq!
#   labels.each { |x| amounts << Person.where( origin: x , :created_at.gt => Date.new($year.to_i),
#                                             :created_at.lt => Date.new($year.to_i + 1)).size }
#
#   labels.each_with_index do |item, index|
#     response << { label: labels[index], amount: amounts[index] }
#   end
#
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response = response.first(5) if response.size >= 4
#
#   response
# end
#
# def self.city
#   labels   = []
#   amounts  = []
#   response = []
#
#   Person.each { |x| labels << x.city if ( x.city && x.city != :"" && x.city != nil ) }
#   labels.uniq!
#   labels.each { |x| amounts << Person.where( city: x, :created_at.gt => Date.new($year.to_i),
#                                             :created_at.lt => Date.new($year.to_i + 1) ).size }
#
#   labels.each_with_index do |item, index|
#     response << { label: labels[index], amount: amounts[index] }
#   end
#
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response = response.first(5) if response.size >= 4
#
#   response
# end
#
# def self.people
#   a_active = 0
#   a_new    = Person.where(
#     :created_at.gt => Date.new($year.to_i),:created_at.lt => Date.new($year.to_i + 1)).size
#
#   Person.each do |x|
#     a_active += 1 if UsedService.where(
#       person_id: x.id, :created_at.gt => Date.new($year.to_i),
#       :created_at.lt => Date.new($year.to_i + 1)
#     ).size > 0
#   end
#
#   response = [{label: 'Nuevas', amount: a_new}, {label: 'Activas', amount: a_active}]
#
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response
# end
#
# def self.services_year
#   labels     = []
#   labels_ids = []
#   amounts    = []
#   response   = []
#
#   Service.each { |x| labels << x.name }
#   labels.each { |x| labels_ids << Service.find_by( name: x ) }
#
#   labels_ids.each do |x|
#     amounts << UsedService.where(
#       service_id: x, :created_at.gt => Date.new($year.to_i),
#       :created_at.lt => Date.new($year.to_i + 1)
#     ).size
#   end
#
#   labels.each_with_index do |item, index|
#     response << { label: labels[index], amount: amounts[index] }
#   end
#
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response
# end

# def self.sandwiches
#   amount = 0
#   Sandwich.where(:created_at.gt => Date.new($year.to_i),
#                  :created_at.lt => Date.new($year.to_i + 1)
#                 ).each { |x| amount += x.amount }
#
#   [{label: 'Bocadillos', amount: amount}]
# end
#
# def self.inv
#   response  = []
#   a_blanket = 0
#   a_sheet   = 0
#   a_jacket  = 0
#   a_shoes   = 0
#   a_basket  = 0
#
#   Article.where(type: 'blanket', :created_at.gt => Date.new($year.to_i),
#                 :created_at.lt => Date.new($year.to_i + 1) ).each { |x| a_blanket += x.amount }
#
#   Article.where( type: 'sheet', :created_at.gt => Date.new($year.to_i),
#                 :created_at.lt => Date.new($year.to_i + 1) ).each { |x| a_sheet   += x.amount }
#
#   Article.where( type: 'jacket', :created_at.gt => Date.new($year.to_i),
#                 :created_at.lt => Date.new($year.to_i + 1) ).each { |x| a_jacket  += x.amount }
#
#   Article.where( type: 'shoes', :created_at.gt => Date.new($year.to_i),
#                 :created_at.lt => Date.new($year.to_i + 1) ).each { |x| a_shoes   += x.amount }
#
#   Article.where( type: 'basket', :created_at.gt => Date.new($year.to_i),
#                 :created_at.lt => Date.new($year.to_i + 1) ).each { |x| a_basket  += x.amount }
#
#   if ( a_blanket > 0 ) then
#     response << {label: 'Mantas', amount: a_blanket}
#   end
#
#   if ( a_sheet > 0 ) then
#     response << {label: 'Sábanas', amount: a_sheet}
#   end
#
#   if ( a_jacket > 0 ) then
#     response << {label: 'Chaquetas', amount: a_jacket}
#   end
#
#   if ( a_shoes > 0 ) then
#     response << {label: 'Zapatos', amount: a_shoes}
#   end
#
#   if ( a_basket > 0 ) then
#     response << {label: 'Canastillas', amount: a_basket}
#   end
#
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response
# end
#
# def self.families
#   families = Family.where( :to.gt => Date.new($year.to_i) )
#   a_new = families.size
#   a_total = 0
#
#   families.each do |x|
#     a_total += x.adults + x.children
#   end
#
#   response = [{ label: "Nuevas", amount: a_new }, { label: "Miembros", amount: a_total }]
#   response.sort_by! { |x| x[:amount] }
#   response.reverse!
#
#   response
# end
end
