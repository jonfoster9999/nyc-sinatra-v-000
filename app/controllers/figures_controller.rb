###MAKE EDIT FORM

class FiguresController < ApplicationController

	get '/figures/new' do
		erb :'/figures/new'
	end

	get '/figures' do
		@figures = Figure.all
		erb :'figures/index'
	end

	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		erb :'figures/show'
	end

	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])
		erb :'figures/edit'
	end

	post '/figures/:id' do
		@figure = Figure.find(params[:id])
		@figure.name = params[:figure][:name]
		@figure.save
		@figure.titles.clear
		@figure.landmarks.clear
		setup(@figures, params)
		redirect "/figures/#{@figure.id}"
	end

	post '/figures' do
		@figure = Figure.find_by(:name => params[:figure][:name]) || Figure.create(:name => params[:figure][:name])
		setup(@figure, params)
		redirect "/figures/#{@figure.id}"
	end

	helpers do
		def setup(figure, params)
			if title_ids = params[:figure][:title_ids]
				title_ids.each do |title_id|
					figure.titles << Title.find(title_id)
				end
				figure.save
			end

			if landmark_ids = params[:figure][:landmark_ids]
				landmark_ids.each do |landmark_id|
					figure.landmarks << Landmark.find(landmark_id)
				end
				figure.save
			end

			if params[:landmark][:name] != ""
				@landmark = Landmark.find_by(:name => params[:landmark][:name]) || Landmark.create(:name => params[:landmark][:name])
				figure.landmarks << @landmark
				figure.save
			end

			if params[:title][:name] != ""
			@title = Title.find_by(:name => params[:title][:name]) || Title.create(:name => params[:title][:name])
				figure.titles << @title
				figure.save
			end
		end
	end
end