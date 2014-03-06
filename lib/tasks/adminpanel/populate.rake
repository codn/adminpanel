namespace :adminpanel do
  desc "Populate database of adminpanel model"

  task :populate, [:times, :model, :attributes] => :environment do |t, args|
    puts "Generating #{args[:times]} records of #{args[:model]}"
    model = "adminpanel/#{args[:model]}".classify.constantize

    attributes = args[:attributes].split(" ")
    prefixes = %W[Sir CEO Entrepeneur Bgr MVP]
    names = %W[Transito Jose Victor John Jane Ramon Katy]
    l_names = %W[Camacho Magana Cuervo Gonzalez Lopez Doe Roe]
    categories = %[CoDN Varios Comestibles Electronicos Web Basura lorem ipsum dolor]
    lorem = %W[Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
      eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
      minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex
      ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
      velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
      cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id
      est laborum.]
    domains = %W[codn.com gmail.com]

    has_image = false
    args[:times].to_i.times do |time|
      instance = model.new
      attributes.each do |attribute|
        field = attribute.split(":").first
        type = attribute.split(":").second

        if type.nil? #no type
          value = "#{time + 1} Lorem ipsum dolor sit amec"

        elsif type == "name" #generate a name
          value = "#{prefixes.sample} #{names.sample} #{l_names.sample}"

        elsif type == "category" #generate a category name
          value = categories.sample

        elsif type == "description" || type == "lorem" #generate random lorem ipsum
          value = ""
          [*60..80].sample.times do
            value = "#{value} #{lorem.sample}"
          end
          value = "#{value}."

        elsif type == "number" #sample number
          value = [*1..500].sample

        elsif type == "id" #assign it to random instanes of Adminpanel::field
          value = "adminpanel/#{field}".classify.constantize.order("RAND()").first.id
          field = "#{field}_id"

        elsif type = "email"
          value = "#{names.sample.first}#{l_names.sample}@#{domains.sample}"

        elsif type == "image" #force an image...
          has_image = true
          @file_url = "http://placehold.it/#{field}"
        end


        if(type != "image")
          instance.send("#{field}=", value)
        end
      end

      instance.save

      if(has_image) #forcing the image into the db
        image_instance = Adminpanel::Image.new(
          :model => model.display_name,
          :foreign_key => instance.id
          )
        image_instance.save(:validate => false)
        image_instance.update_column(:file, @file_url)
      end

    end

  end
end
