class Report
  def self.genre
    man_amount = Person.where(genre: 'man', :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count
    woman_amount = Person.where(genre: 'woman', :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count

    response = [{label: 'Hombres', amount: man_amount}, {label: 'Mujeres', amount: woman_amount}]

    response.sort_by! { |x| x[:amount] }
    response.reverse!

    response
  end

  def self.spanish
    spanish_amount = Person.where(:origin.in => ['españa','España'], :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count
    foreign_amount = Person.where( :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).count - spanish_amount

    response = [{label: 'Extranjeros', amount: foreign_amount}, {label: 'Españoles', amount: spanish_amount}]

    response.sort_by! { |x| x[:amount] }
    response.reverse!

    response
  end

  def self.documentation
    indocumentados = Person.where(documentation: 0, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count
    regularizados = Person.where(documentation: 1, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count
    irregulares= Person.where(documentation: 2, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count

    response = [{label: 'Indocumentados', amount: indocumentados}, {label: 'Regularizados', amount: regularizados}, {label: 'Sin Regularizar', amount: irregulares}]
    response.sort_by! { |x| x[:amount] }
    response.reverse!

    response
  end

  def self.assistance
    primera_vez = Person.where(assistance: 0, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count
    habitual = Person.where(assistance: 1, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count
    reincidente= Person.where(assistance: 2, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count

    response = [{label: 'Primera vez', amount: primera_vez}, {label: 'Habitual', amount: habitual}, {label: 'Reincidente', amount: reincidente}]

    response.sort_by! { |x| x[:amount] }
    response.reverse!

    response
  end

  def self.residence
    de_paso = Person.where(residence: 0, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count
    residente = Person.where(residence: 1, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count

    response = [{label: 'De Paso', amount: de_paso}, {label: 'Residente', amount: residente}]

    response.sort_by! { |x| x[:amount] }
    response.reverse!

    response
  end

  def self.origin
    labels = []
    amounts = []
    response = []

    Person.each { |x| labels << x.origin }
    labels.each { |x| amounts << Person.where( origin: x , :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1)).count }

    labels.each_with_index do |item, index|
      response << { label: labels[index], amount: amounts[index] }
    end

    response.sort_by! { |x| x[:amount] }
    response.reverse!

    response = response.first(5) if response.count >= 4

    response
  end

  def self.city
    labels = []
    amounts = []
    response = []

    Person.each { |x| labels << x.city if ( x.city && x.city != :"" && x.city != nil ) }
    labels.each { |x| amounts << Person.where( city: x, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).count }

    labels.each_with_index do |item, index|
      response << { label: labels[index], amount: amounts[index] }
    end

    response.sort_by! { |x| x[:amount] }
    response.reverse!

    response = response.first(5) if response.size >= 4

    response
  end

  def self.people
    a_new = Person.where( :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).count
    a_active =0

    Person.each { |x| a_active += 1 if UsedService.where( person_id: x.id, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).count > 0 }

    response = [{label: 'Nuevas', amount: a_new}, {label: 'Activas', amount: a_active}]

    response.sort_by! { |x| x[:amount] }
    response.reverse!

    response
  end

  def self.services_year
    labels = []
    labels_ids = []
    amounts = []
    response = []

    Service.each { |x| labels << x.name }
    labels.each { |x| labels_ids << Service.find_by( name: x ) }
    labels_ids.each { |x| amounts << UsedService.where( service_id: x, :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).count }

    labels.each_with_index do |item, index|
      response << { label: labels[index], amount: amounts[index] }
    end

    response.sort_by! { |x| x[:amount] }
    response.reverse!

    response
  end

  def self.sandwiches
    amount = 0
    Sandwich.where( :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).each do |x|
      amount += x.amount
    end

    [{label: 'Bocadillos', amount: amount}]
  end

  def self.inv
    response = []
    a_blanket = 0
    a_sheet    = 0
    a_jacket   = 0
    a_shoes    = 0
    a_basket  = 0
    a_others1 = 0
    a_others2 = 0
    a_others3 = 0

    Article.where( type: 'blanket', :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).each do |x|
      a_blanket += x.amount
    end

    Article.where( type: 'sheet', :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).each do |x|
      a_sheet += x.amount
    end

    Article.where( type: 'jacket', :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).each do |x|
      a_jacket += x.amount
    end

    Article.where( type: 'shoes', :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).each do |x|
      a_shoes += x.amount
    end

    Article.where( type: 'basket', :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).each do |x|
      a_basket += x.amount
    end

    Article.where( type: 'others1', :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).each do |x|
      a_others1 += x.amount
    end

    Article.where( type: 'others2', :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).each do |x|
      a_others2 += x.amount
    end

    Article.where( type: 'others3', :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) ).each do |x|
      a_others3 += x.amount
    end

    if ( a_blanket > 0 ) then
      response << {label: 'Mantas', amount: a_blanket}
    end

    if ( a_sheet > 0 ) then
      response << {label: 'Sábanas', amount: a_sheet}
    end

    if ( a_jacket > 0 ) then
      response << {label: 'Chaquetas', amount: a_jacket}
    end

    if ( a_shoes > 0 ) then
      response << {label: 'Zapatos', amount: a_shoes}
    end

    if ( a_basket > 0 ) then
      response << {label: 'Canastillas', amount: a_basket}
    end

    if ( a_others1 > 0 ) then
      response << {label: 'Otros 1', amount: a_others1}
    end

    if ( a_others2 > 0 ) then
      response << {label: 'Otros 2', amount: a_others2}
    end

    if ( a_others3 > 0 ) then
      response << {label: 'Otros 3', amount: a_others3}
    end

    response.sort_by! { |x| x[:amount] }
    response.reverse!

      response
  end

  def self.families
    families = Family.where( :created_at.gt => Date.new($year.to_i), :created_at.lt => Date.new($year.to_i + 1) )
    a_new = families.count
    a_total = 0

    families.each do |x|
      a_total += x.adults + x.children
    end

    response = [{ label: "Nuevas", amount: a_new }, { label: "Miembros", amount: a_total }]
    response.sort_by! { |x| x[:amount] }
    response.reverse!

    response
  end
end
