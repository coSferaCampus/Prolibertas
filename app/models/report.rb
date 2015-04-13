class Report
  def genre
    data = [{genre: 'hombres', amount: 60}, {genre: 'mujeres', amount: 90}]
    
    # man_amount = Person.where(genre: 'man').count
    # data << { "Hombres" => man_amount}

    # woman_amount = Person.where(genre: 'woman').count
    # data << { "Mujeres" => woman_amount}

    data
  end
end