class ListsController < ApplicationController
    before_action :authenticate_user!

    def index
        @lists = current_user.lists.order(created_at: :desc)
        @pagy, @lists = pagy(@lists) 
    end

    def show
        @list = current_user.lists.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to_root_path
    end 

    def new
        @list = current_user.lists.new
    end 

    def create
        @list = current_user.lists.new(list_params)  
        if @list.save
          redirect_to @list
        else
          render :new, status: :unprocessable_entity
        end
    end

    def edit 
        @list = current_user.lists.find(params[:id])
    end 

    def update 
        @list = current_user.lists.find(params[:id])
        if @list.update(list_params)
            redirect_to @list, notice: "List updated successfully"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @list = current_user.lists.find(params[:id])
        @list.destroy
        redirect_to root_path, notice: "List deleted successfully"
    end 

    private

    def list_params 
        params.require(:list).permit(:title)
    end
end
