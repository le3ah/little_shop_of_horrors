class Admin::MerchantsController < Admin::BaseController  
    def index
        @merchants = User.where('role = 1')
    end

    def show
    end 

    def toggle_status
        user = User.find(params[:user_id])

        user.switch_enabled

        redirect_to admin_merchants_path
    end 
  
end 