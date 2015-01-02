require 'rails/generators/active_record'
module Adminpanel
  class DumpGenerator < ActiveRecord::Generators::Base
    desc "Generate a dump for a given resource"
    # source_root File.expand_path("../templates", __FILE__)
    argument :name, type: :string, require: true
    class_option :'inject-into-seeds',
      :type => :boolean,
      :aliases => '-i',
      :default => true,
      :desc => "Skip injection into seeds.rb"

    def create_json_file
      resource = name.demodulize.camelize.singularize
      resource = "Adminpanel::#{resource}".classify.constantize
      file_name = resource.to_s.pluralize.demodulize.downcase + '.json'
      puts "dumping #{resource.display_name.pluralize(I18n.default_locale)} into db/#{file_name}"

      create_file "db/#{file_name}" do
        resource.all.to_a.map{|o| o.attributes}.to_json
      end
      inject_into_seeds(resource, file_name)
    end

  private
    def inject_into_seeds(resource, file_name)
      if options[:'inject-into-seeds']
        append_to_file 'db/seeds.rb' do
          "\nobjects = JSON.parse(open(\"\#{Rails.root}/db/#{file_name}\").read)\n" +
          "objects.each do |element|\n" +
            indent("object = #{resource}.new\n", 2) +
            indent("element.each do |k,v|\n", 2) +
              indent("object[k] = v\n", 4) +
            indent("end\n", 2) +
            indent("object.save\n", 2) +
          "end\n"
        end
      end
    end
  end
end
