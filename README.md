# Committee::Minitest::Rails

Mintest plugin to generate Open API Spec coverage with Committee and Rails.

## Usage

`test_helper.rb`

```ruby
Committee::Minitest::Rails.schema_path = "path-to-spec.yml"
# optional
Committee::Minitest::Rails.path_filter = "api"

class ActionDispatch::IntegrationTest
  include Committee::Minitest::Rails::TestMethods
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/committee-minitest-rails.
