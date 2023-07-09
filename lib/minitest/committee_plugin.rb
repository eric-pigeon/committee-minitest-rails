# frozen_string_literal: true

module Minitest
  class CommitteeCoverageReporter < AbstractReporter
    attr_accessor :schema_coverage

    def initialize
      @schema_coverage = {}
    end

    def record(result)
      @schema_coverage = Committee::Test::SchemaCoverage.merge_report(
        @schema_coverage,
        result.committee_coverage
      )
    end

    def report
      report = Committee::Coverage::Report.new(@schema_coverage)
      puts "API coverage: #{report.covered_percent}"
      Committee::Coverage::HTMLFormatter.new(report).format
    end
  end

  def self.plugin_committee_init(options)
    self.reporter << CommitteeCoverageReporter.new
  end

  module ResultExtension
    def from(runnable)
      super.tap do |r|
        r.committee_coverage =
          if runnable.respond_to? :schema_coverage
            runnable.schema_coverage.report
          else
            {}
          end
      end
    end
  end

  Result.singleton_class.prepend(ResultExtension)
  Result.attr_accessor :committee_coverage
end
