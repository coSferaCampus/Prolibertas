class Report
  def self.genre
    man_amount = Person.where(genre: 'man').count
    woman_amount = Person.where(genre: 'woman').count

    data = [{genre: 'hombres', amount: man_amount}, {genre: 'mujeres', amount: woman_amount}]
  end
end