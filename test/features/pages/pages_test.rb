require 'test_helper'

class PagesTest < ViewCase

  setup :sign_in

  test "when root path Admipnanel.displayed_pages are in the menu" do
    visit adminpanel.root_path
    assert page.has_selector?('.accordion-toggle.accordion-navigation.spinner-link', text: 'Random Page')
    assert page.has_link?('Random Page', href: adminpanel.page_path(Adminpanel::RandomPage.instance))
  end

  test "when visiting a random page it should display all its form fields" do
    Adminpanel::RandomPage.instance.update(header: 'Hola', slogan: 'Saludo cordial', body: '<div>lorem</div>')
    visit adminpanel.page_path(Adminpanel::RandomPage.instance)
    assert page.has_content?('Cabecera')
    assert page.has_content?('Hola')
    assert page.has_content?('Slogan')
    assert page.has_content?('Saludo cordial')
    assert page.has_content?('lorem')
    assert page.has_link?('', href: adminpanel.edit_page_path(Adminpanel::RandomPage.instance))
  end

  test "when editing a random page it should display and update form fields" do
    Adminpanel::RandomPage.instance.update(header: '', slogan: '', body: '')
    visit adminpanel.edit_page_path(Adminpanel::RandomPage.instance)
    fill_in 'random_page_header', with: 'sum header'
    fill_in 'random_page_slogan', with: 'a fine slogan'
    page.execute_script(
      %Q(
        var editor = $('#body-trix-editor')[0].editor;
        editor.insertString("a fine body");
      )
    ) # to fill the wysiwyg editor
    click_button 'Actualizar Random Page'

    assert_equal 'sum header', Adminpanel::RandomPage.instance.header
    assert_equal 'a fine slogan', Adminpanel::RandomPage.instance.slogan
    assert_equal '<div>a fine body</div>', Adminpanel::RandomPage.instance.body
    assert 1, Adminpanel::RandomPage.count
    assert_equal adminpanel.page_path(Adminpanel::RandomPage.instance), page.current_path
  end

  private
    def sign_in
      visit adminpanel.signin_path
      login
    end
end
