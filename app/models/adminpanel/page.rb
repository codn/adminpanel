module Adminpanel
  class Page < ActiveRecord::Base
    include Adminpanel::Base

    def self.mount_uploader(attribute, uploader)
      super attribute, uploader
      define_method "#{attribute}_will_change!" do
        fields_will_change!
        instance_variable_set("@#{attribute}_changed", true)
      end
      define_method "#{attribute}_changed?" do
        instance_variable_get("@#{attribute}_changed")
      end
      define_method "write_uploader" do |column, identifier|
        fields[column.to_s] = identifier
      end
      define_method "read_uploader" do |column|
        fields[column.to_s]
      end
    end

    def self.whitelisted_attributes(params)
      params.require(self.name.to_s.underscore.split('/').last).permit!
    end

    def write_uploader(column, identifier)

    end

    def read_uploader(column)
    end

  end
end
