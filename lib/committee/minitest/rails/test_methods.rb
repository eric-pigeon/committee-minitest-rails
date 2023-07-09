# frozen_string_literal: true

module Committee
  module Minitest
    module Rails
      module TestMethods
        include ::Committee::Test::Methods

        def committee_options
          @committee_options ||= begin
            schema = Committee::Drivers.load_from_file(
              Committee::Minitest::Rails.schema_path,
              parser_options: { strict_reference_validation: true }
            )
            {
              schema: schema,
              schema_coverage: Committee::Test::SchemaCoverage.new(schema)
            }
          end
        end

        def schema_coverage
          committee_options[:schema_coverage]
        end

        def request_object
          @request_object ||= RequestObject
            .new(integration_session.request)
        end

        def response_data
          [
            integration_session.response.status,
            integration_session.response.headers,
            integration_session.response.body
          ]
        end
      end
    end
  end
end
