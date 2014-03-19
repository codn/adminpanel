module Adminpanel
  class Photo < ActiveRecord::Base
    attr_accessible :shoe_id, :file

    mount_uploader :file, PhotoUploader
    # belongs_to :shoe

    def self.form_attributes
      [
			{
				'shoe_id' => {
					'type' => 'belongs_to',
					'model' => 'Adminpanel::Shoe',
					'name' => 'shoe',
					'label' => 'shoe',
					'placeholder' => 'shoe'}
			},
			{
				'file' => {
					'type' => 'text_field',
					'name' => 'file',
					'label' => 'file',
					'placeholder' => 'file'}
			},
      ]
    end

    def self.display_name
      "Photo"
    end

    # def self.icon
    #     "icon-truck"
    # end
  end
end
