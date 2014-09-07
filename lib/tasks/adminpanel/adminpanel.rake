namespace :adminpanel do
  desc "Interact with adminpanel models :D"

  task :section, [:name, :section, :type] => :environment do |t, args|
    args.with_defaults(:section => "home", :name => "greeting", :type => "")
    puts "Creating #{args[:name]} in #{args[:section]} section"

    s = Adminpanel::Section.new(
      :name => args[:name].titleize,
      :has_description => false,
      :description => "",
      :key => (args[:name].downcase.tr(' ','_')),
      :page => args[:section].capitalize,
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
    puts "Creating/overwriting webmaster@codn.com with password #{password}"
    user = Adminpanel::User.find_by_email('webmaster@codn.com')
    if !user.nil?
      user.delete
    end

    role = Adminpanel::Role.find_by_name("Admin")
    if role.nil?
      role = Adminpanel::Role.new(:name => "Admin")
      role.save
    end
    Adminpanel::User.new(
      :email => 'webmaster@codn.com',
      :name => 'Webmaster',
      :password => password,
      :password_confirmation => password,
      :role_id => role.id
    ).save
  end

  task :dump_sections => :environment do |t|
    puts "Dumping adminpanel_sections table into db/seeds.rb"
    File.open("#{Rails.root.join('db', 'seeds.rb')}", "w") do |f|
        f << "Adminpanel::Section.delete_all\n"
      Adminpanel::Section.all.each do |section|
        f << "#{creation_command_section(section)}"
      end
    end
  end

  task :dump_categories => :environment do |t|
    puts "Dumping adminpanel_categories table into db/seeds.rb"
    File.open("#{Rails.root.join('db', 'seeds.rb')}", "w") do |f|
        f << "Adminpanel::Section.delete_all\n"
      Adminpanel::Section.all.each do |section|
        f << "#{creation_command_categories(section)}"
      end
    end
  end

  task :dump, [:resource] => :environment do |t, args|
    resource = args[:resource].demodulize.camelize.singularize
    resource = "Adminpanel::#{resource}".classify.constantize
    file_name = resource.to_s.pluralize.demodulize.downcase + '.yml'
    puts "dumping #{resource.display_name.pluralize(I18n.default_locale)} into db/#{file_name}"
    File.open("#{Rails.root.join('db', file_name)}", "w") do |f|
      YAML::dump(resource.all.to_a, f)
      # resource.all.each do |object|
      #   f << object.to_yaml
      # end
    end

    # haven't been able to make inject_into_file work :(
    puts "insert this into: #{Rails.root.join('db', 'seeds.rb')}"
    puts "seeded = YAML::load_file(File.join(Rails.root, 'db', '#{file_name}'))"
    puts "seeded.each do |record|"
    puts "  #{resource}.create record.attributes"
    puts "end"
  end

  task :populate, [:times, :model, :attributes] => :environment do |t, args|
    require 'faker'
    I18n.reload!
    puts "Generating #{args[:times]} records of #{args[:model]}"

    @model = "adminpanel/#{args[:model]}".classify.constantize

    attributes = args[:attributes].split(" ")

    args[:times].to_i.times do |time|
      instance = @model.new
      attributes.each do |attribute|
        field = attribute.split(":").first
        type = attribute.split(":").second

        case type
          when 'name' #generate a name
            value = Faker::Name.name

          when 'category' || 'category_name' #generate a category name
            value = Faker::Commerce.product_name

          when 'lorem' || 'description' #large paragraph.
            value = Faker::Lorem.paragraph([*1..10].sample)

          when 'number' #generate a number
            value = [*1..7000].sample

          when 'url' #generate an url
            value = Faker::Internet.url
          when 'id' #assign field_id it to a random instance of Adminpanel::field
            field = field.downcase.singularize
            if field != 'category'
              value = "adminpanel/#{field}".classify.constantize.order('RAND()').first.id
            else
              value = "adminpanel/#{field}".classify.constantize.of_model(@model.display_name).order('RAND()').first.id
            end
              field = "#{field}_id"

          when 'email' #generates a random email
            value = Faker::Internet.email

          when 'lat_mid' #latitude for merida, yucatan, mx.
            value = float_random(21.046929, 20.903954)
          when 'lng_mid' #longitude for merida, yucatan, mx.
            value = float_random(-89.699819, -89.567296)

          when 'lat'
            value = Faker::Address.latitude
          when 'lng'
            value = Faker::Address.longitude

          when 'image' || 'images'
            3.times do
              instance.send("#{@model.name.demodulize.downcase}files").build
            end
          else #no type || not found
            value = Faker::Lorem.words([*1..6].sample).join(' ') #lorem random short sentence

        end

        if(type != 'image')
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
    "\t:description => \"#{escape_double_quotes(section.description)}\",\n" +
    "\t:key => \"#{section.key}\",\n" +
    "\t:page => \"#{section.page}\",\n" +
    "\t:has_image => #{section.has_image}\n" +
    ").save\n"
  end

  def creation_command_category(category)
    "Adminpanel::Category.new(\n" +
    "\t:name => \"#{escape_double_quotes(category.name)}\",\n" +
    "\t:model => \"#{category.model}\"\n" +
    ").save\n"
  end

  def escape_double_quotes(string)
    string.gsub('"', '\\"')
  end

  def change_dates(instance)
    date = rand(Date.parse('2010-01-01')..Date.today)
    instance.update_attribute(:created_at, date)
    instance.update_attribute(:updated_at, date)
  end

  def float_random(min_number, max_number)
    width = max_number - min_number
    return (rand*width)+min_number
  end
