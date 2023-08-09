class ItemsController < ApplicationController
    before_action :authenticate_user!

    def create 
        @list = current_user.lists.find(params[:list_id])
        @item = @list.items.build(item_params)
        if @item.save
            redirect_to list_path(@list)
        else
            render "lists/show"
        end
    end

    def destroy
        @list = current_user.lists.find(params[:list_id])
        @item = @list.items.find(params[:id])
        @item.destroy
        redirect_to list_path(@list)
    end

    def update
        @list = current_user.lists.find(params[:list_id])
        @item = @list.items.find(params[:id])
        @item.update(completed: params[:completed])
    end

    private 

    def item_params 
        params.require(:item).permit(:title)
    end
end

