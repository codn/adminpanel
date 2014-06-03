require 'test_helper'

module Adminpanel
  class SectionTest < ActiveSupport::TestCase

    def test_telephone_validations
      set_telephone
      assert @telephone.valid?

      @telephone.update_attribute(:description, '1' * 9)
      assert @telephone.invalid?

      @telephone.update_attribute(:description, '1' * 11)
      assert @telephone.invalid?

      @telephone.update_attribute(:description, '01-2-3-4-5')
      assert @telephone.invalid?

      @telephone.update_attribute(:description, '')
      assert @telephone.valid?
    end

    def test_default_scope
      assert_equal(
        Adminpanel::Section.all.to_sql,
        Adminpanel::Section.reorder('').order('page ASC').to_sql
      )
    end

  protected
    def set_telephone
      @telephone = Adminpanel::Section.new(
        name: 'Telefono',
        key: 'phone',
        has_description: false,
        description: '1234567890',
        page: 'home',
        has_image: false
      )
    end

    def set_description
      @description = Adminpanel::Section.new(
        name: 'Inicio',
        key: 'greeting',
        has_description: true,
        description: 'lorem ipsum dolor sit amec',
        page: 'home',
        has_image: false
      )
    end
  end
end
