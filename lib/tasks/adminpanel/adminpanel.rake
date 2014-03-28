namespace :adminpanel do
  desc "Interact with adminpanel models :D"

  task :section, [:section, :name, :type] => :environment do |t, args|
    args.with_defaults(:section => "home", :name => "greeting", :type => "")
    puts "Creating #{args[:name]} in #{args[:section]} section"

    s = Adminpanel::Section.new(
      :name => args[:name].titleize,
      :has_description => false,
      :description => "",
      :key => (args[:name].tr(' ','_')),
      :page => args[:section],
      :has_image => false
    )

    args[:type].split(" ").each do |type|
      case type
        when "wysiwyg" || "description"
          s.has_description = true
        when "images"
          s.has_image = true
      end
    end
    s.save
  end

  task :user => :environment do |t|
    characters = []
    characters.concat(("a".."z").to_a)
    characters.concat(("A".."Z").to_a)
    characters.concat((0..9).to_a)
    characters.concat(%w[! @ \# $ % ^ & * , _ - + =])
    password = ""
    8.times do
      password = password + "#{characters.sample}"
    end
    puts "Creating/overwriting admin@codn.com with password #{password}"
    user = Adminpanel::User.find_by_email('admin@codn.com')
    if !user.nil?
      user.delete
    end

    Adminpanel::User.new(
      :email => 'admin@codn.com',
      :name => 'CoDN',
      :password => password,
      :password_confirmation => password
    ).save
  end

  task :dump => :environment do |t|
    puts "Dumping adminpanel_sections and adminpanel_categories into db/seeds.rb"
    File.open("db/seeds.rb", "w") do |f|
        f << "Adminpanel::Section.delete_all\n"
        f << "Adminpanel::Category.delete_all\n"
      Adminpanel::Section.all.each do |section|
        f << "#{creation_command_section(section)}"
      end
      Adminpanel::Category.all.each do |category|
        f << "#{creation_command_category(category)}"
      end
    end
  end

  task :dump_sections => :environment do |t|
    puts "Dumping adminpanel_sections table into db/seeds.rb"
    File.open("db/seeds.rb", "w") do |f|
        f << "Adminpanel::Section.delete_all\n"
      Adminpanel::Section.all.each do |section|
        f << "#{creation_command_section(section)}"
      end
    end
  end

  task :dump_categories => :environment do |t|
    puts "Dumping adminpanel_categories table into db/seeds.rb"
    File.open("db/seeds.rb", "w") do |f|
        f << "Adminpanel::Section.delete_all\n"
      Adminpanel::Section.all.each do |section|
        f << "#{creation_command_categories(section)}"
      end
    end
  end

  task :populate, [:times, :model, :attributes] => :environment do |t, args|
    puts "Generating #{args[:times]} records of #{args[:model]}"

    @model = "adminpanel/#{args[:model]}".classify.constantize

    attributes = args[:attributes].split(" ")

    init_variables

    has_image = false
    args[:times].to_i.times do |time|
      instance = @model.new
      attributes.each do |attribute|
        field = attribute.split(":").first
        type = attribute.split(":").second

        case type
          when "name" #generate a name
            value = generate_name

          when "category" || "category_name" #generate a category name
            value = @things.sample.pluralize

          when 'lorem_short'
            value = generate_lorem_name #lorem random short sentence

          when "lorem" || "description" #large paragraph.
            value = generate_lorem

          when "number" #generate a number
            value = [*1..5000].sample

          when "id" #assign field_id it to a random instance of Adminpanel::field
            field = field.downcase.singularize
            if field != 'category'
              value = "adminpanel/#{field}".classify.constantize.order("RAND()").first.id
            else
              value = "adminpanel/#{field}".classify.constantize.of_model(@model.display_name).order("RAND()").first.id
            end
              field = "#{field}_id"

          when "email" #generates a random email
            value = generate_email

          else #no type
            value = "#{time + 1} Lorem ipsum dolor sit amec"

        end

        if(type != "image")
          instance.send("#{field}=", value)
        end
      end

      instance.save(:validate => false)

      change_dates(instance)

    end

  end
end

private

  def creation_command_section(section)
    "Adminpanel::Section.new(\n" +
    "\t:name => \"#{section.name}\",\n" +
    "\t:has_description => #{section.has_description},\n" +
    "\t:description => \"#{section.description}\",\n" +
    "\t:key => \"#{section.key}\",\n" +
    "\t:page => \"#{section.page}\",\n" +
    "\t:has_image => #{section.has_image}\n" +
    ").save\n"
  end

  def creation_command_category(category)
    "Adminpanel::Category.new(\n" +
    "\t:name => \"#{category.name}\",\n" +
    "\t:model => \"#{category.model}\"\n" +
    ").save\n"
  end

  def generate_lorem
    value = "#{@lorem.sample}"
    [*60..80].sample.times do
      value = "#{value} #{@lorem.sample}"
    end
    "#{value}."
  end

  def generate_lorem_name
    value = "#{@lorem.sample}"
    [*0..3].sample.times do
      value = "#{value} #{@lorem.sample}"
    end
    "#{value.titleize}."
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

  def change_dates(instance)
    date = rand(3.years).ago
    instance.update_attribute(:created_at, date)
    instance.update_attribute(:updated_at, date)
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
      est laborum. Sed dapibus condimentum tempor. Curabitur tortor libero,
      malesuada ac varius at, adipiscing non ante. Ut at neque vitae massa
      volutpat bibendum a vel purus. Cras adipiscing accumsan placerat. Praesent
      rhoncus pellentesque felis, vel faucibus ipsum convallis dictum. Donec
      congue vitae risus quis sagittis. Interdum et malesuada fames ac ante
      ipsum primis in faucibus. Suspendisse rhoncus tortor ut urna eleifend
      molestie. Phasellus in viverra tortor. Pellentesque sagittis tortor tortor,
      at auctor risus elementum non. Morbi sagittis ante tincidunt congue
      fermentum. Quisque ac tellus in lacus interdum ultrices. Mauris ornare
      justo nec sapien tempor, sit amet dapibus massa tincidunt. Interdum et
      malesuada fames ac ante ipsum primis in faucibus. Nullam sodales ac mauris
      eget egestas. Maecenas rhoncus ac metus quis condimentum. Vestibulum
      consequat lacus nulla, eu varius leo consectetur vitae. Pellentesque vitae
      sem mauris. Suspendisse ornare, dui eget elementum aliquam, augue neque
      condimentum leo, nec ullamcorper lectus massa quis nibh. Etiam id egestas
      mauris, eget eleifend enim.
    ]
    @domains = %W[codn.com gmail.com hotmail.com codn.mx codn.com.mx]
    @adjective_denominations = %W[Nice Pretty Good Ugly Expensive Cheap Useful]
    @things = %W[T-shirt Cellphone Laptop iPhone Android Beer Belt Headphone
      Apple\ TV iMac Macbook\ pro iPod\ touch Github's\ octocat Mug Template
    ]
end
