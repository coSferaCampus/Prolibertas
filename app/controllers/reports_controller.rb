class ReportsController < ApplicationController
  respond_to :json

  def genre
    @genre = Report.genre
    puts "EL GENERO ES: #{@genre}"
    respond_with @genre.to_json
  end
end
