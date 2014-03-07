    namespace :adminpanel do
    desc "Populate database of adminpanel model"

    task :populate, [:times, :model, :attributes] => :environment do |t, args|
      # if Rails.env === "development"
      puts "Generating #{args[:times]} records of #{args[:model]}"
      # end
      puts t
      model = "adminpanel/#{args[:model]}".classify.constantize

      attributes = args[:attributes].split(" ")

      init_variables

      has_image = false
      args[:times].to_i.times do |time|
        instance = model.new
        attributes.each do |attribute|
          field = attribute.split(":").first
          type = attribute.split(":").second

          case type
            when "name" #generate a name
              value = generate_name

            when "category" #generate a category name
              value = @things.sample.pluralize

            when "description"
              value = generate_lorem

            when "number" #generate a number
              value = [*1..500].sample

            when "id" #assign field_id it to a random instance of Adminpanel::field
              value = "adminpanel/#{field}".classify.constantize.order("RAND()").first.id
              field = "#{field}_id"

            when "email" #generates a random email
              value = generate_email

            when "image" #force an image...
              has_image = true
              @file_url = "http://placehold.it/#{field}"

            when "thing" #like products name
              value = generate_thing

            else #no type
              value = "#{time + 1} Lorem ipsum dolor sit amec"

          end

          if(type != "image")
            instance.send("#{field}=", value)
          end
        end

        instance.save

        change_update_date(instance)

        if(has_image) #forcing the image into the db
          create_image_associated_to_id(instance.id)
        end

      end

    end
  end

private

  def create_image_of(model_id)
    image_instance = Adminpanel::Image.new(
      :model => model.display_name,
      :foreign_key => model_id
      )
    image_instance.save(:validate => false)
    image_instance.update_column(:file, @file_url)
    change_update_date(image_instance)
  end

  def generate_lorem
    value = ""
    [*60..80].sample.times do
      value = "#{value} #{@lorem.sample}"
    end
    "#{value}."
  end

  def generate_email
    "#{@names.sample.first}#{@l_names.sample}@#{@domains.sample}"
  end

  def generate_name
    "#{@prefixes.sample} #{@names.sample} #{@l_names.sample}"
  end

  def generate_thing
    "#{@adjective_denominations} #{@things.sample}"
  end

  def change_update_date(instance)
    instance.update_attribute(:updated_at, rand(3.years).ago)
  end

  def init_variables
    @prefixes = %W[Sir CEO Entrepeneur Bgr MVP]
    @names = %W[Transito Jose Victor John Jane Ramon Katy Sean Emma]
    @l_names = %W[Camacho Ferreira Gonzalez Lopez Doe Roe Williams Holmes]
    @lorem = %W[Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
      eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
      minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex
      ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
      velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
      cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id
      est laborum.]
    @domains = %W[codn.com gmail.com hotmail.com codn.mx codn.com.mx]
    @adjective_denominations = %W[Nice Pretty Good Ugly Expensive Cheap Useful]
    @things = %W[T-shirt Cellphone Laptop iPhone Android Beer Belt Headphone
      Apple\ TV iMac Macbook\ pro iPod\ touch Github's\ octocat Mug Template
    ]
end
