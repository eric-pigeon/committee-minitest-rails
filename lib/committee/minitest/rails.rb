# frozen_string_literal: true

require_relative "rails/version"
require_relative "rails/test_methods"
require_relative "rails/request_object"
require_relative "../coverage/html_formatter"
require_relative "../coverage/report"

module Committee
  module Minitest
    module Rails
      class Error < StandardError; end

      mattr_accessor :schema_path, :path_filter

      def self.project_name
        @project_name ||= File.basename(root.split("/").last).capitalize.tr("_", " ")
      end

      def self.root
        @root ||= File.expand_path(Dir.getwd)
      end
    end
  end
end
