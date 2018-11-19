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
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    elsif !params["pet"]["owner_id"].empty? && params[:owner][:name].empty?
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    if @pet.owner != nil
      @owner = @pet.owner
    end
    @owners = Owner.all

    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    @pet = Pet.find_by_id(params[:id])
    @pet.update(params[:pet])

    if !params[:owner][:name].empty? && params[:owner][:name] != @pet.owner.name
      owner = Owner.create(name: params[:owner][:name])
      @pet.owner = owner
      @pet.save
    end

  end

end
