module Adminpanel
  class AdminpanelFormBuilder < ActionView::Helpers::FormBuilder
    include ApplicationHelper
    alias_method :text_field_original, :text_field
    alias_method :radio_button_original, :radio_button
    alias_method :text_area_original, :text_area
    alias_method :password_field_original, :password_field
    alias_method :number_field_original, :number_field
    alias_method :email_field_original, :email_field
    alias_method :file_field_original, :file_field
    # alias_method :select_original, :select

    def text_field name, *args
      base_layout name, *args, 'text_field_original'
    end

    def file_field name, *args
      image_input = base_layout(name, *args, 'file_field_original')

      if !object.nil? && !object.new_record? #if not new record
        "#{thumbnail_layout(name)}#{image_input}".html_safe
      else
        image_input
      end
    end

    def non_image_file_field name, *args
      file_input = base_layout(name, *args, 'file_field_original')

      if !object.nil? && !object.new_record? #if not new record
        "#{title_layout(name)}#{file_input}".html_safe
      else
        file_input
      end
    end

    def gallery_field name, *args
      base_layout name, *args, 'gallery_base'
    end

    def wysiwyg_field name, *args

      options = args.extract_options!
      options.reverse_merge! class: 'wysihtml5 span7'

      base_layout name, options, 'text_area_original'
    end

    def text_area name, *args
      base_layout name, *args, 'text_area_original'
    end

    # def radio_button_group(name, buttons, options)
    # 	options.reverse_merge! :label => name
    # 	options.reverse_merge! :html => {}
    # 	output = ""
    #
    # 	buttons.each do |b|
    # 		output += @template.content_tag(:label, radio_button_original(name, b, options[:html]) + b.capitalize, :class => "radio")
    # 	end
    #
    # 	@template.content_tag :div, :class => "control-group" do
    # 		@template.content_tag(:label, options[:label], :class => "control-label") +
    # 		@template.content_tag(:div, output, { :class => "controls"}, false)
    # 	end
    # end

    def checkbox checkbox_object, form_object_name, relationship
      @template.content_tag(
        :label,
        @template.check_box_tag(
          "#{form_object_name}[#{relationship}][]",
          checkbox_object.id,
          self.object.send(relationship).include?(checkbox_object.id)
          ) + checkbox_object.name,
        class: "checkbox"
      )
    end

    def boolean name, *args
      base_layout name, *args, 'boolean_base'
    end

    def enum_field name, *args
      select(
        name,
        self.object.class.send(name.pluralize).map{|option, value|
          [I18n.t("#{self.object.class.name.demodulize.downcase}.#{option}"), option]
        },
        *args
      )
    end

    def resource_select name, *args
      select name, Adminpanel.displayable_resources.map{|resource| [symbol_class(resource).display_name, resource.to_s]}, *args
      # select name, Adminpanel.displayable_resources.map{|resource| ['resource', 'resource']}, *args

    end

    def select(name, select_options, *args)
      options = args.extract_options!
      label = options['label']
      options.delete('label')

      options.reverse_merge! class: 'span7', include_blank: '(Seleccione por favor)';

      @template.content_tag :div, class: "control-group" do
        @template.content_tag(:label, label, class: "control-label") +
        @template.content_tag(:div, super(name, select_options, options), class: "controls")
      end
    end

    def number_field(name, *args)
      base_layout( name, *args, 'number_field_original' )
    end

    def password_field(name, *args)
      base_layout( name, *args, 'password_field_original' )
    end

    def email_field(name, *args)
      base_layout( name, *args, 'email_field_original' )
    end

    def submit(name, *args)
      options = args.extract_options!

      options.reverse_merge! class: "btn btn-primary"
      super(name, *args << options)
    end

    def datepicker(name, *args)
      base_layout( name, *args, 'datepickerize_base' )
    end

    # def prepend_field(name, *args)
    #
    #   options = args.extract_options!
    #
    #   options.reverse_merge! :label => name
    #   label = options['label']
    #   options.delete('label')
    #
    #   options.reverse_merge! :symbol => "#"
    #   symbol = options[:symbol]
    #   options.delete(:symbol)
    #
    #   @template.content_tag :div, :class => "control-group" do
    #     @template.content_tag(:label, label, :class => "control-label") +
    #     @template.content_tag(
    #       :div,
    #       @template.content_tag(
    #         :div,
    #         @template.content_tag(:span, symbol, :class => "add-on") +
    #         text_field_original(name, *args << options),
    #         :class => "input-prepend"
    #       ),
    #       :class => "controls"
    #     )
    #   end
    # end
    #
    # def append_field(name, *args)
    #
    #   options = args.extract_options!
    #
    #   options.reverse_merge! :label => name
    #   label = options['label']
    #   options.delete('label')
    #
    #   options.reverse_merge! :symbol => "#"
    #   symbol = options[:symbol]
    #   options.delete(:symbol)
    #
    #   @template.content_tag :div, :class => "control-group" do
    #     @template.content_tag(:label, label, :class => "control-label") +
    #     @template.content_tag(
    #       :div,
    #       @template.content_tag(
    #         :div,
    #         text_field_original(name, *args << options) +
    #         @template.content_tag(:span, symbol, :class => "add-on"),
    #         :class => "input-append"
    #       ),
    #       :class => "controls"
    #     )
    #   end
    # end

    private

    def base_layout(name, *args, input_type)
      options = args.extract_options!
      options.reverse_merge! class: 'span7'
      label = options['label']
      options.delete('label')

      @template.content_tag :div, class: 'control-group' do
        @template.content_tag(:label, label, class: 'control-label') +
        @template.content_tag(:div, class: 'controls') do
          self.send(input_type, name, options)
        end
      end
    end

    def datepickerize_base(name, options)
      options.reverse_merge! 'value' => Time.now.strftime("%d-%m-%Y")
      @template.content_tag(
                :div,
                class: 'input-append date datepicker datepicker-basic',
                data: {
                  date_format: 'dd-mm-yyyy',
                  date: options['value']
                }
              ) do
        text_field_original(name, options) +
        (
          @template.content_tag :span, class: 'add-on' do
            @template.content_tag :i, nil, class: 'fa fa-th'
          end
        )
      end
    end

    def boolean_base(name, options)
      @template.content_tag :label, class: 'checkbox' do
        check_box(name)
      end
    end

    def gallery_base(name, options)
      file_field_input = file_field_original(name, options)
      hidden_input = hidden_field(:_destroy)
      delete_button = @template.content_tag(:button, I18n.t("action.delete"), class: "btn btn-danger remove-fields")

      if object.nil? || object.new_record?
        "#{file_field_input}#{hidden_input}#{delete_button}".html_safe
      else
        "#{thumbnail_layout(name)}#{file_field_input}#{hidden_input}#{delete_button}".html_safe
      end
    end

    def thumbnail_layout(attribute)
      @template.content_tag :div, class: 'control-group' do
        @template.content_tag :div, class: 'controls' do
          @template.image_tag self.object.send("#{attribute}_url", :thumb)
        end
      end
    end

    def title_layout(attribute)
      @template.content_tag :div, class: 'control-group' do
        @template.content_tag :div, class: 'controls' do
          @template.content_tag(:i, I18n.t('adminpanel.form.server_file', file: self.object["#{attribute}"]))
        end
      end
    end

  end
end
