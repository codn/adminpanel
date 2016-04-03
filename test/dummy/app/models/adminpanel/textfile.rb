module Adminpanel
  class Textfile < Image
    include Adminpanel::Base
    mount_uploader :file, FileResourcefileUploader

  end
end
