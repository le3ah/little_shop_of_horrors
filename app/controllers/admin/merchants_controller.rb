class Admin::MerchantsController < Admin::BaseController  
    def index
        @merchants = User.where('role = 1')
    end

    def show
    end 
    
end 