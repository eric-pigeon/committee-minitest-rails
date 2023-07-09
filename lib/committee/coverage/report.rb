# frozen_string_literal: true

module Committee
  module Coverage
    class Report
      attr_reader :report

      def initialize(report)
        @report = Committee::Test::SchemaCoverage.flatten_report(report)
      end

      def responses
        @responses ||= begin
          path_filter = unless Committee::Minitest::Rails.path_filter.nil?
            Regexp.new Committee::Minitest::Rails.path_filter
          end

          report[:responses]
            .select { |response| path_filter.nil? || path_filter.match?(response[:path]) }
            .sort_by { |response| response[:path] }
        end
      end

      def covered_responses
        @covered_responses ||= responses.count { |response| response[:is_covered] }
      end

      def missed_responses
        @missed_responses ||= responses.count { |response| !response[:is_covered] }
      end

      def covered_percent
        format("%.2f", covered_responses.to_f * 100 / responses.count)
      end
    end
  end
end
