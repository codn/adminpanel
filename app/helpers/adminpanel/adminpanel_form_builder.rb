module Adminpanel
	class AdminpanelFormBuilder < ActionView::Helpers::FormBuilder

		alias_method :text_field_original, :text_field
		alias_method :radio_button_original, :radio_button
		alias_method :parent_file_field, :file_field

		def text_field(name, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "span7"
			label = options['label']
			options.delete('label')

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, super(name, *args << options), :class => "controls")
			end
		end

		def file_field(name, *args)
			options = args.extract_options!
			label = options['label']
			options.delete('label')


			image = @template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, super(name, *args << options), :class => "controls")
			end

			if object.nil? || object.new_record?
				image
			else
				thumbnail = @template.content_tag :div, :class => 'control-group' do
					@template.content_tag :div, :class => 'controls' do
						@template.image_tag object.send("#{name}_url", :thumb)
					end
				end

				"#{thumbnail}#{image}".html_safe
			end
		end

		def gallery_field(name, *args)
			options = args.extract_options!
			label = options['label']
			options.delete('label')

			@template.content_tag :div, :class => "control-group" do
				label = @template.content_tag(:label, label, :class => "control-label")
				input = @template.content_tag :div, :class => "controls" do
					input = parent_file_field(name, *args << options)
					hidden_input = hidden_field(:_destroy)
					delete_button = @template.content_tag(:button, I18n.t("action.delete"), :class => "btn btn-danger remove_fields")

					if object.nil? || object.new_record?
						"#{input}#{hidden_input}#{delete_button}".html_safe
					else
						thumbnail = @template.content_tag :div, :class => 'control-group' do
							@template.image_tag object.send("#{name}_url", :thumb)
						end

						"#{thumbnail}#{input}#{hidden_input}#{delete_button}".html_safe
					end
				end
				"#{label}#{input}".html_safe
			end
		end

		def wysiwyg_field(name, *args)
			options = args.extract_options!
			label = options['label']
			options.delete('label')

			@template.content_tag(:div, :class => 'control-group') do
				@template.content_tag(:label, label, :class => 'control-label') +
				@template.content_tag(:div, :class => 'controls') do
					self.text_area(
						name,
						class: 'wysihtml5 span10',
						placeholder: I18n.t('wysiwyg.description'),
						rows: '6'
					)
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

		def checkbox(checkbox_object, form_object_name, relationship)
			@template.content_tag(
				:label,
				@template.check_box_tag(
					"#{form_object_name}[#{relationship}][]",
					checkbox_object.id,
					self.object.send(relationship).include?(checkbox_object.id)
					) + checkbox_object.name,
				:class => "checkbox"
			)
		end

		def boolean(name, *args)
			options = args.extract_options!

			@template.content_tag(
				:div,
				@template.content_tag(
					:div,
					options['label'],
					:class => 'control-label') +
					@template.content_tag(
						:div,
						@template.content_tag(
							:label,
							check_box(
								name
							),
							:class => 'checkbox'
						),
						:class => 'controls'
					),
				:class => 'control-group'
			)
		end

		def select(name, select_options, *args)
			options = args.extract_options!
			label = options['label']
			options.delete('label')

			options.reverse_merge! :class => "span7"

			options.reverse_merge! :include_blank => "(Seleccione por favor)";

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, super(name, select_options, *args << options), :class => "controls")
			end
		end

		def number_field(name, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "span5"
			options.reverse_merge! :label => name
			label = options['label']
			options.delete('label')

			@template.content_tag :div, :class => "control-group" do
				@template.content_tag(:label, label, :class => "control-label") +
				@template.content_tag(:div, super(name, *args << options), :class => "controls")
			end
		end

		def password_field(name, *args)
			options = args.extract_options!

			options.reverse_merge! :class => "span7"
			label = options['label']
			options.delete('label')

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
			label = options['label']
			options.delete('label')

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
			label = options['label']
			options.delete('label')

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
			label = options['label']
			options.delete('label')

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
