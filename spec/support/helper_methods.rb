def valid_signin_as_admin(user)
	user.update_attribute(:group_id, get_admin_group.id)
	fill_in 'inputEmail', :with => user.email
	fill_in 'inputPassword', :with => user.password
	click_button 'signin-button'
end

def get_admin_group
	group = Adminpanel::Group.find_by_name('Admin')
	if group.nil?
		FactoryGirl.create(:group)
		group = Adminpanel::Group.find_by_name('Admin')
	end
	group
end

def get_user
	if Adminpanel::User.count == 0
		FactoryGirl.create(:user)
	elsif Adminpanel::User.count == 1
		Adminpanel::User.first
	else
		Adminpanel::User.delete_all
		get_user
	end
end

def clean_uploads_folder
	FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/."])
end
