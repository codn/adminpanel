module Adminpanel
	class CustomFormBuilder < ActionView::Helpers::FormBuilder

		alias_method :text_field_original, :text_field
		alias_method :radio_button_original, :radio_button
		alias_method :checkbox_original, :check_box

		def text_field(name, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "span7"
			options.reverse_merge! :label => name
			label = options[:label]
			options.delete(:label)

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, super(name, *args << options), :class => "controls")
			end
		end

		def adminpanel_file_field(name, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "span7"
			options.reverse_merge! :label => name
			label = options[:label]
			options.delete(:label)

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, file_field(name, *args << options), :class => "controls")
			end
		end

		def wysiwyg_field(name, *args)
			options = args.extract_options!
			label = options["label"]
			options.delete("label")

			@template.content_tag(:div, :class => "control-group") do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, :class => "controls") do
					if self.object.send(name).nil?
						@template.content_tag(
							:div, 
							self.object.send(name), 
							:id => name,
							"data-placeholder" => I18n.t("Write description here")
						)
					else
						@template.content_tag(
							:div, 
							self.object.send(name).html_safe, 
							:id => name,
							"data-placeholder" => I18n.t("Write description here")
						)
					end
				end
			end
		end

		def radio_button_group(name, buttons, options)

			options.reverse_merge! :label => name
			options.reverse_merge! :html => {}
			output = ""

			buttons.each do |b|
				output += @template.content_tag(:label, radio_button_original(name, b, options[:html]) + b.capitalize, :class => "radio")
			end

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, options[:label], :class => "control-label") +
				@template.content_tag(:div, output, { :class => "controls"}, false)
			end
		end

		def check_box(name, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "span7"
			options.reverse_merge! :label => name
			options.reverse_merge! :include_blank => "(Seleccione por favor)";
			label = options[:label]
			options.delete(:label)

			@template.content_tag(:label, super(name, *args) + label, :class => "checkbox")
		end

		def select(name, select_options, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "span7"
			options.reverse_merge! :label => name
			options.reverse_merge! :include_blank => "(Seleccione por favor)";
			label = options[:label]
			options.delete(:label)

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, super(name, select_options, *args << options), :class => "controls")
			end
		end

		def number_field(name, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "span5"
			options.reverse_merge! :label => name
			label = options[:label]
			options.delete(:label)

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, super(name, *args << options), :class => "controls")
			end
		end

		def password_field(name, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "span7"
			options.reverse_merge! :label => name
			label = options[:label]
			options.delete(:label)

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, super(name, *args << options), :class => "controls")
			end
		end

		def text_area(name, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "span7"
			options.reverse_merge! :rows => "10"
			options.reverse_merge! :label => name
			label = options[:label]
			options.delete(:label)

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, super(name, *args << options), :class => "controls")
			end
		end

		def submit(name, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "btn btn-primary"
			super(name, *args << options)
		end

		def datepicker(name, *args)

			options = args.extract_options!

			options.reverse_merge! :value => Time.now.strftime("%d-%m-%Y")
			options.reverse_merge! :label => name
			label = options[:label]
			options.delete(:label)

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(
					:div, 
					@template.content_tag(
						:div,
						text_field_original(name, *args << options) + 
						@template.content_tag(
							:span,
							@template.content_tag(
								:i,
								nil,
								:class => "icon-th"
							),
							:class => "add-on" 
						),
						{
							:class => "input-append date span5 datepicker datepicker-basic",
							:data => {
								:date_format => "dd-mm-yyyy",
								:date => options[:value]
							}
						}
					), 
					:class => "controls"
				)
			end
		end

		def prepend_field(name, *args)

			options = args.extract_options!

			options.reverse_merge! :label => name
			label = options[:label]
			options.delete(:label)

			options.reverse_merge! :symbol => "#"
			symbol = options[:symbol]
			options.delete(:symbol)

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(
					:div,
					@template.content_tag(
						:div,
						@template.content_tag(:span, symbol, :class => "add-on") +
						text_field_original(name, *args << options),
						:class => "input-prepend" 
					), 
					:class => "controls"
				)
			end
		end

		def append_field(name, *args)

			options = args.extract_options!

			options.reverse_merge! :label => name
			label = options[:label]
			options.delete(:label)

			options.reverse_merge! :symbol => "#"
			symbol = options[:symbol]
			options.delete(:symbol)

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(
					:div,
					@template.content_tag(
						:div,
						text_field_original(name, *args << options) +
						@template.content_tag(:span, symbol, :class => "add-on"),
						:class => "input-append" 
					), 
					:class => "controls"
				)
			end
		end
	end
end