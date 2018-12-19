RSpec.describe "User can be admin" do

    it 'can be an admin' do 
        admin = User.new(name:"sweet christmas", email: 'test@test.com', password:"hownow", role: 2, 
                address: "123 road street", city: "denver", zip:12345, state: "co")
        expect(admin.role).to eq("admin")
        expect(admin.admin?).to be_truthy 
    end 

    it 'can not be an admin' do
        user = User.new(name:"sweet christmas", email: 'test@test.com', password:"hownow", role: 0, 
                address: "123 road street", city: "denver", zip:12345, state: "co")
        expect(user.role).to eq("default")
        expect(user.admin?).to_not be_truthy
    end

end
