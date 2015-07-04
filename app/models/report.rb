class Report
  def self.genre
    man_amount = Person.where(genre: 'man').count
    woman_amount = Person.where(genre: 'woman').count

    [{label: 'Hombres', amount: man_amount}, {label: 'Mujeres', amount: woman_amount}]
  end

  def self.spanish
    spanish_amount = Person.where(:origin.in => ['españa','España']).count
    foreign_amount = Person.all.count - spanish_amount

    [{label: 'Españoles', amount: spanish_amount}, {label: 'Extranjeros', amount: foreign_amount}]
  end

  def self.documentation
    indocumentados = Person.where(documentation: 0).count
    regularizados = Person.where(documentation: 1).count
    irregulares= Person.where(documentation: 2).count

    [{label: 'Indocumentados', amount: indocumentados}, {label: 'Regularizados', amount: regularizados}, {label: 'Sin Regularizar', amount: irregulares}]
  end

  def self.assistance
    primera_vez = Person.where(assistance: 0).count
    habitual = Person.where(assistance: 1).count
    reincidente= Person.where(assistance: 2).count

    [{label: 'Primera vez', amount: primera_vez}, {label: 'Habitual', amount: habitual}, {label: 'Reincidente', amount: reincidente}]
  end

  def self.residence
    de_paso = Person.where(residence: 0).count
    residente = Person.where(residence: 1).count

    [{label: 'De Paso', amount: de_paso}, {label: 'Residente', amount: residente}]
  end

end
