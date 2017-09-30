require "test_helper"

class GetSchwifty::HelperTest < ActionView::TestCase
  include GetSchwifty::Helper

  test "renders a div with a data-get-schwifty attribute" do
    output = get_schwifty "controller#action"
    assert_match(/<div data-get-schwifty=\"\w+\"><\/div>/, output)
  end

  test "renders a div with a data-get-schwifty attribute and block" do
    output = get_schwifty "controller#action" do "<p>hey</p>".html_safe; end
    assert_match(/<div data-get-schwifty=\"\w+\"><p>hey<\/p><\/div>/, output)
  end

  test "renders a div with a data-get-schwifty attribute and params" do
    output = get_schwifty "controller#action", { id: 1 }
    assert_match(/<div data-get-schwifty=\"\w+\" data-get-schwifty-params=\"\{.+\}\"><\/div>/, output)
  end
end
