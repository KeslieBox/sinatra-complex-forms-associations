class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all

    erb :'/pets/new'
  end

  post '/pets' do 
    @owners = Owner.all
    @pet = Pet.create(params[:pet])
   
    if !params[:owner][:name].empty?
      owner = Owner.create(params[:owner]) 
      @pet.owner = owner
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by(id: params[:id])
    @owners = Owner.all
    @owner = Owner.find_by(id: params[:id])

    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find_by(id: params[:id])
    @owner = Owner.find_by(id: params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
     ####### bug fix
     if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
      end
      #######
  
      @pet = Pet.find(params[:id])
      @pet.update(params[:pet])
      if !params[:owner][:name].empty?
        owner = Owner.create(params[:owner]) 
        @pet.owner = owner
        @pet.save
      end
    redirect to "pets/#{@pet.id}"
  end
end