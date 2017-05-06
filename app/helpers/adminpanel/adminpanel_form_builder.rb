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
    alias_method :time_select_original, :time_select

    def body(&block)
      @template.content_tag :div, class: 'widget-body' do
        @template.content_tag :div, class: 'widget-forms clearfix' do
          yield
        end
      end
    end

    def footer(&block)
      @template.content_tag :div, class: 'widget-footer' do
        yield
      end
    end

    def text_field(method, *args)
      base_layout method, *args, 'text_field_original'
    end

    def image_field(method, *args)
      image_input = base_layout(method, *args, 'file_field_original')

      if !object.nil? && !object.new_record? #if not new record
        "#{thumbnail_layout(method)}#{image_input}".html_safe
      else
        image_input
      end
    end

    def file_field(method, *args)
      file_input = base_layout(method, *args, 'file_field_original')

      if !object.nil? && !object.new_record? #if not new record
        "#{title_layout(method)}#{file_input}".html_safe
      else
        file_input
      end
    end

    def gallery_field(method, *args)
      base_layout method, *args, 'gallery_base'
    end

    def wysiwyg_field(method, *args)

      options = args.extract_options!

      options[:trix_id] = "trix-#{method}-#{self.object.object_id}"
      hidden_field(
          method,
          id: options[:trix_id]
        ) + base_layout(
          method,
          options,
          'trix_field'
      )
    end

    def text_area(method, *args)
      base_layout method, *args, 'text_area_original'
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

    def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {})
      super method, collection, value_method, text_method, options, html_options do |b|
        b.label class: 'checkbox' do
          b.check_box +
          b.label
        end
      end
    end

    def boolean(method, *args)
      base_layout method, *args, 'boolean_base'
    end

    def enum_field(method, *args)
      select(
        method,
        self.object.class.send(method.to_s.pluralize).map{|option, value|
          [I18n.t("#{self.object.class.name.demodulize.downcase}.#{option}"), option]
        },
        *args
      )
    end

    def resource_select(method, *args)
      select method, Adminpanel.displayable_resources.map{|resource| [symbol_class(resource).display_name, resource.to_s]}, *args
    end

    def select(method, select_options, *args)
      options = args.extract_options!
      label = options['label']
      options.delete('label')

      options.reverse_merge! class: 'span7', include_blank: '(Seleccione por favor)';

      @template.content_tag :div, class: "control-group" do
        @template.content_tag(:label, label, class: "control-label") +
        @template.content_tag(:div, super(method, select_options, options), class: "controls")
      end
    end

    def number_field(method, *args)
      base_layout( method, *args, 'number_field_original' )
    end

    def password_field(method, *args)
      base_layout( method, *args, 'password_field_original' )
    end

    def email_field(method, *args)
      base_layout( method, *args, 'email_field_original' )
    end

    def submit(method, *args)
      options = args.extract_options!

      options.reverse_merge!(
        class: 'btn btn-primary',
        data: {
          disable_with: I18n.t('action.submitting')
        }
      )
      super(method, *args << options)
    end

    def datepicker(method, *args)
      base_layout( method, *args, 'datepickerize_base' )
    end

    def hours_select(method, *args)
      base_layout( method, *args, 'time_select_original' )
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

    protected

      def trix_field(method, *args)
        options = args.extract_options!
        options.reverse_merge! input: options[:trix_id], id: "#{method}-trix-editor"
        options[:class] << ' trix-content'
        options[:data] ||= {}
        editor_images = []
        if options['uploader'].present?
          options[:data][:uploader_name] = options['uploader'].to_s
          options[:data][:uploader_class] = "Adminpanel::#{options['uploader'].to_s.singularize.capitalize}"
          relation_name = "#{options['uploader'].to_s.singularize}_ids"
          editor_images = self.object.send(options['uploader'].to_s)
          empty_uploader_field = @template.hidden_field_tag "#{self.object.class.name.demodulize.underscore}[#{relation_name}][]"
        end

        editor = @template.content_tag 'trix-editor', options do
          self.object.send(method)
        end
        editor_images_fields = editor_images.map {|image|
          @template.hidden_field_tag(
            "#{self.object.class.name.demodulize.underscore}[#{relation_name}][]",
            image.id,
            data: {
              url: image.file_url(:thumb)
            }
          )
        }.join('').html_safe
        editor + empty_uploader_field + editor_images_fields
      end

    private

      def base_layout(method, *args, input_type)
        options = args.extract_options!
        options.reverse_merge! class: 'span7'
        label = options['label']
        options.delete('label')

        @template.content_tag :div, class: 'control-group' do
          @template.content_tag(:label, label, class: 'control-label') +
          @template.content_tag(:div, class: 'controls') do
            self.send(input_type, method, options)
          end
        end
      end

      def datepickerize_base(method, options)
        options['data'] ||= {}
        options['data']['date_format'] ||= 'dd-mm-yyyy'
        options['data']['date'] ||= Time.now.strftime("%d-%m-%Y")
        options['value'] = options['data']['date']

        @template.content_tag(
                  :div,
                  class: 'input-append date datepicker datepicker-basic',
                  data: options['data']
                ) do
          text_field_original(method, options) +
          (
            @template.content_tag :span, class: 'add-on' do
              @template.content_tag :i, nil, class: 'fa fa-th'
            end
          )
        end
      end

      def boolean_base(method, options)
        @template.content_tag :label, class: 'checkbox' do
          check_box(method)
        end
      end

      def gallery_base(method, options)
        file_field_input = file_field_original(method, options)
        hidden_input = hidden_field(:_destroy)
        delete_button = @template.content_tag(:button, I18n.t("action.delete"), class: "btn btn-danger remove-fields")

        if object.nil? || object.new_record?
          "#{file_field_input}#{hidden_input}#{delete_button}".html_safe
        else
          "#{thumbnail_layout(method)}#{file_field_input}#{hidden_input}#{delete_button}".html_safe
        end
      end

      def thumbnail_layout(attribute)
        @template.content_tag :div, class: 'control-group' do
          @template.content_tag :div, class: 'controls' do
            @template.image_tag(self.object.send("#{attribute}_url", :thumb)) unless self.object.send("#{attribute}_url", :thumb).nil?
          end
        end
      end

      def title_layout(attribute)
        @template.content_tag :div, class: 'control-group' do
          @template.content_tag :div, class: 'controls' do
            @template.content_tag(:i, I18n.t('adminpanel.form.server_file', file: self.object.send(attribute).to_s.split('/').last))
          end
        end
      end
    end
end
