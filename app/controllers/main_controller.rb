class MainController < ApplicationController
	def main
		render text: '', layout: 'application'
	end
end