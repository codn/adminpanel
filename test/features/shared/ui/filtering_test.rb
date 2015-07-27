require 'test_helper'

class FilteringTest < ViewCase
  fixtures :all

  setup :sign_in

  def test_input_is_present
    assert_selector '#search-input'
  end

  def test_filters_all_elements_when_nothing_matched
    fill_in 'search-input', with: 'abcdeffj nothing matches this'
    # 1 since search-input is inside an .accordion-group
    assert_selector '.accordion-group', count: 1
  end

  def test_filter_to_only_matched_element
    fill_in 'search-input', with: 'pRODuct'
    # 2 since search-input is inside an .accordion-group
    assert_selector '.accordion-group', count: 2
  end

  protected
    def sign_in
      visit adminpanel.signin_path
      login
    end
end
