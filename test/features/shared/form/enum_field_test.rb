require 'test_helper'

class EnumFieldTest < ViewCase

  setup :sign_in

  def test_enum_field
    visit adminpanel.new_permission_path
    select_selector = find('#permission_action')

    assert select_selector.find('option', text: 'Ver')
    assert select_selector.find('option', text: 'Publicar en Redes Sociales')
    assert select_selector.find('option', text: 'Crear')
    assert select_selector.find('option', text: 'Actualizar')
    assert select_selector.find('option', text: 'Borrar')
    assert select_selector.find('option', text: 'Administrar')
  end

  private
    def sign_in
      visit adminpanel.signin_path
      login
    end
end
