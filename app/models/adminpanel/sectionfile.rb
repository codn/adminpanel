module Adminpanel
  class Sectionfile < Image
    include Adminpanel::Base

    mount_uploader :file, Adminpanel::SectionUploader
  end
end
