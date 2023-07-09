# frozen_string_literal: true

module Committee
  module Coverage
    class HTMLFormatter
      attr_reader :report

      delegate :responses,
        :covered_responses,
        :missed_responses,
        :covered_percent,
        to: :report

      def initialize(report)
        @report = report
      end

      def format
        File.open(File.join(output_path, "index.html"), "wb") do |file|
          template = ERB.new(File.read(File.join(File.dirname(__FILE__), "index.html.erb")))

          file.puts template.result(binding)
        end
      end

      def project_name
        Committee::Minitest::Rails.project_name
      end

      def output_path
        @output_path ||= File.expand_path("api-coverage").tap do |path|
          FileUtils.mkdir_p path
        end
      end

      def assets_path(name)
        File.join("./assets", name)
      end

      def asset_output_path
        @asset_output_path ||= File.join(output_path, "assets").tap do |path|
          FileUtils.mkdir_p(path)
        end
      end
    end
  end
end
