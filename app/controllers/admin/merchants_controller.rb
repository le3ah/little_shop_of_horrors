class Admin::MerchantsController < Admin::BaseController  
    def index
        @merchants = User.where('role = 1')
    end

    def show
    end 


    def toggle_status
        user = User.find(toggle_params[:user_id])

        user.switch_enabled

        redirect_to admin_merchants_path
    end 


    private 

    def toggle_params
        params.permit(:enabled, :user_id)
    end
    
end 