module Adminpanel
  class Sectionfile < ActiveRecord::Base
    include Adminpanel::Base

    validates_presence_of :file

    mount_uploader :file, Adminpanel::SectionUploader
  end
end
