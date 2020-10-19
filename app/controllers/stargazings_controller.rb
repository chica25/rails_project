class StargazingsController < ApplicationController
    before_action :set_stargazing

    def new
        @stargazing = Stargazing.new
        @constellation = Constellation.find_by_id(params[:constellation_id]) if params[:constellation_id]
    end

    def create
        @stargazing = current_user.stargazings.new(stargaze_params)
        if @stargazing.save
            redirect_to stargazing_path(@stargazing)
        else
            render :new
        end
    end

     def index
        # @stargazings = Stargazing.find_by_constellation_id(params[:constellation_id])

     @stargazings = Stargazing.all
     end
   # @comments = Comment.find_by_skatespot_id(params[:skatespot_id])

    # def show
    #     @stargazings = Stargazing.find_by_constellation_id(params[:constellation_id])
    # end
 
    def edit 
        set_stargazing
    end
    # redirect_to skatespot_comments_path(@comment.skatespot, @comment)

    def update
       # byebug
        set_stargazing
        if current_user.stargazings.update(stargaze_params)
            redirect_to constellation_stargazing_path(@stargazing)
           
        else
            render :edit
         end
    end

   

    def destroy
        @stargazing = Stargazing.find_by_id(params[:id])
        @stargazing.delete
        redirect_to stargazings_path
    end
    
    private
    def stargaze_params
        params.require(:stargazing).permit(:location, :weather, :time, :constellation_id)
    end

    def set_stargazing
        @stargazing = Stargazing.find_by_id(params[:id])
    end

end

