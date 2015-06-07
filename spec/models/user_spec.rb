# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
	 before do
    	@user = User.new(name: "Example User", email: "user@example.com", 
    	                 password: "foobar", password_confirmation: "foobar")
 	end

	subject { @user }

	it { should respond_to (:name) }
	it { should respond_to (:email) }
	it { should respond_to (:password_digest) }
	it { should respond_to (:password) }
	it { should respond_to (:admin) }
	it { should respond_to (:password_confirmation) }
	it { should respond_to (:remember_token) }
	it { should respond_to (:authenticate) }

	it { should be_valid }

	describe "with admin attribute set to 'true'" do
		before do
			@user.save!
			@user.toggle!(:admin)
		end

		it { should be_admin }
	end

	describe "When name is not present" do
		before { @user.name = " "}
		it { should_not be_valid }
	end 

	describe "When Email is not present" do
		before { @user.email = " "}
		it { should_not be_valid}
	end

	describe "when name is to long" do
		before { @user.name = "x" * 51 }
		it { should_not be_valid }
	end

	describe "when email addresses are invalid" do
		it "should be invalid" do
			addresses = %w[userid@domain,com userid_at_domain.com userid@domain. 
								userid@domain_domain.com userid@domain+domain.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end 
		end
	end

	describe "when email addresses are valid" do
		it "should be valid" do
			addresses = %w[userid@domain.com A_US-ER@f.b.org frst.lst@domain.jp a+b@domain.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end 

	describe "When email address is already in use" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "email address with mixed case" do
		let(:mixed_case_email) {"uSeR@eXaMpLe.CoM"}

		it "should be saved in all lower case" do
			@user.email = mixed_case_email
			@user.save
			@user.reload.email.should == mixed_case_email.downcase
		end
	end

	describe "when password fields are empty" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password field does not match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "when a password confirmation is nill" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end 

	describe "with a password that's too short" do
    	before { @user.password = @user.password_confirmation = "a" * 5 }
    	it { should be_invalid }
  	end

  	describe "return value of authenticate method" do
    	before { @user.save }
    	let(:found_user) { User.find_by_email(@user.email) }
    

	    describe "with valid password" do
	      it { should == found_user.authenticate(@user.password) }
	    end

	    describe "with invalid password" do
	      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

	      it { should_not == user_for_invalid_password }
	      specify { user_for_invalid_password.should be_false }
	    end
	end

	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end

	#describe "accessible attributes" do
	#	it "should not allow access to admin" do
	#		User.new(admin: user.admin)
	#	end
	#	end
	#end
end
