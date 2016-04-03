require 'test_helper'

class ResourceFieldTest < ViewCase

  setup :sign_in

  def test_resource_select_with_its_display_names
    visit adminpanel.new_permission_path

    selector = find('#permission_resource')

    assert selector.find('option', text: 'Categoria')
    assert selector.find('option', text: 'Producto')
    assert selector.find('option', text: 'Analytics')
    assert selector.find('option', text: 'Usuario')
    assert selector.find('option', text: 'Rol')
    assert selector.find('option', text: 'Permiso')
    assert selector.find('option', text: 'Sección')
    assert selector.find('option', text: 'Taza')
    assert selector.find('option', text: 'Departamento')
    assert selector.find('option', text: 'Galeria')
    assert selector.find('option', text: 'FileResource')
    assert selector.find('option', text: 'Agente')
    # assert false
  end

  private
    def sign_in
      visit adminpanel.signin_path
      login
    end
end
