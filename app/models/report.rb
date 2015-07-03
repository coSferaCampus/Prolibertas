class Report
  def self.genre
    man_amount = Person.where(genre: 'man').count
    woman_amount = Person.where(genre: 'woman').count

    data = [{label: 'Hombres', amount: man_amount}, {label: 'Mujeres', amount: woman_amount}]
  end

  def self.spanish
    spanish_amount = Person.where(:origin.in => ['españa','España']).count
    foreign_amount = Person.all.count - spanish_amount

    data = [{label: 'Españoles', amount: spanish_amount}, {label: 'Extranjeros', amount: foreign_amount}]
  end
end
