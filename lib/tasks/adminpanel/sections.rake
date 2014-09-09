namespace :adminpanel do
  namespace :test do
    desc "Testing adminpanel performance and other stuff"

    task single_section_ips: :environment do |t|
      puts "Benchmark retrieving a single section (Iteration Per Second)"
      Benchmark.ips do |x|
        x.report("DQ-where-:key-=>-\"value\"") { Adminpanel::Section.where(:key => "contact-email").first() }
        x.report("where-:key-=>-'value'") { Adminpanel::Section.where(:key => 'contact-email').first() }
        x.report("DQ-where-key:-\"value\"") { Adminpanel::Section.where(key: "contact-email").first() }
        x.report("where-key:-'value'") { Adminpanel::Section.where(key: 'contact-email').first() }
        x.report("DQ-find_by_key(\"key\")") { Adminpanel::Section.find_by_key("contact-email") }
        x.report("find_by_key('key')") { Adminpanel::Section.find_by_key('contact-email') }
      end
    end

    task find_with_conditions: :environment do |t|
      puts "Benchmark retrieving a section with find_by_key vs find_by(key: 'value')"
      Benchmark.ips do |x|
        x.report("find_by_key('key')") { Adminpanel::Section.find_by_key('contact-email') }
        x.report("find_by(key: 'key')") { Adminpanel::Section.find_by(key: 'contact-email') }
      end
    end

    task collections_of_a_page_ips: :environment do |t|
      puts "Benchmark retrieving a collection (Iteration Per Second)"
      Benchmark.ips do |x|
        x.report("DQ-where-:page-=>-\"Areas\"") do
          @sections = Adminpanel::Section.where(:page => "Areas")
          @about = @sections.where(:key => "acerca-de-nosotros")
          @mission = @sections.where(:key => "mision")
          @history = @sections.where(:key => "historia")
        end
        x.report("where-:page-=>-'Areas'") do
          @sections = Adminpanel::Section.where(:page => 'Areas')
          @about = @sections.where(:key => 'acerca-de-nosotros')
          @mission = @sections.where(:key => 'mision')
          @history = @sections.where(:key => 'historia')
        end
        x.report("DQ-where-page:-\"Areas\"") do
          @sections = Adminpanel::Section.where(page: "Areas")
          @about = @sections.where(key: "acerca-de-nosotros")
          @mission = @sections.where(key: "mision")
          @history = @sections.where(key: "historia")
        end
        x.report("where-page:-'Areas'") do
          @sections = Adminpanel::Section.where(page: 'Areas')
          @about = @sections.where(key: 'acerca-de-nosotros')
          @mission = @sections.where(key: 'mision')
          @history = @sections.where(key: 'historia')
        end
        x.report("DQ-find_by_key-each") do
          @about = Adminpanel::Section.find_by_key("acerca-de-nosotros")
          @mission = Adminpanel::Section.find_by_key("mision")
          @history = Adminpanel::Section.find_by_key("historia")
        end
        x.report("find_by_key-each") do
          @about = Adminpanel::Section.find_by_key('acerca-de-nosotros')
          @mission = Adminpanel::Section.find_by_key('mision')
          @history = Adminpanel::Section.find_by_key('historia')
        end
      end
    end
  end
end
