class PokemonsController < ApplicationController
    def capture
	p = Pokemon.find(params[:id])
	p.trainer_id = current_trainer.id
	#@pokemon.update_attribute(:trainer_id, current_trainer.id)
	p.save
        redirect_to root_path 
    end 
	
   def damage
	p = Pokemon.find(params[:id])
	p.health = p.health-10
	p.save
	redirect_to trainer_path(p.trainer_id)
   end 

    def heal
	p = Pokemon.find(params[:id])
	p.health = p.health + 10
	p.save
	redirect_to trainer_path(p.trainer_id)
   end 

   def new 
   end


   def create
	@pokemon = Pokemon.new(pokemon_params)
	@pokemon.level = 1
	@pokemon.health = 100
	@pokemon.trainer_id = current_trainer.id
	if @pokemon.save
		redirect_to current_trainer
	else
		flash[:error] = @pokemon.errors.full_messages.to_sentence		
		redirect_to new_pokemon_path
	end
end

	private 

	def pokemon_params
		params.require(:pokemon).permit(:name)
	end
	
end
