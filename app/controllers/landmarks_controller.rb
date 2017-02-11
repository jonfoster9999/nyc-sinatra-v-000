class LandmarksController < ApplicationController

	get '/landmarks/new' do
		erb :'landmarks/new'
	end

	get '/landmarks' do
		@landmarks = Landmark.all
		erb :'landmarks/index'
	end

	get '/landmarks/:id/edit' do
		@landmark = Landmark.find(params[:id])
		erb :'landmarks/edit'
	end

	get '/landmarks/:id' do
		@landmark = Landmark.find(params[:id])
		erb :'landmarks/show'
	end

	post '/landmarks/:id' do
		@landmark = Landmark.find(params[:id])
		@landmark.name = params[:landmark][:name]
		@landmark.year_completed = params[:landmark][:year_completed]
		@landmark.save
		redirect "/landmarks/#{@landmark.id}"
	end

	post '/landmarks' do
		landmark_hash = params[:landmark]
		@landmark = Landmark.find_by(:name => landmark_hash[:name]) || Landmark.create(:name => landmark_hash[:name], :year_completed => landmark_hash[:year_completed].to_i)
	end

end
