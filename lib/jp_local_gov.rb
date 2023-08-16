# frozen_string_literal: true

require_relative "jp_local_gov/version"
require_relative "jp_local_gov/local_gov"
require_relative "jp_local_gov/base"


  module_function

  def included(model_class)
    model_class.extend Base
  end

  def find(local_gov_code)

    local_gov_data = data[local_gov_code.to_sym]
    return nil if local_gov_data.nil?

    JpLocalGov::LocalGov.new(local_gov_data)
  end

  def where(conditions)
    return nil unless conditions.is_a?(Hash)


      build_local_gov(data, conditions)
    end.flatten.compact
    return nil if results.empty?

    results
  end


  def build_local_gov(data, conditions)
    data.values
        .select { |target| filter(target, conditions) }
        .tap { |result| return nil if result.empty? }
        .map { |result| JpLocalGov::LocalGov.new(result) }
  end

  def filter(target, conditions)
    conditions.map { |condition| target[condition[0]] == condition[1] }.all?
  end


  private_constant :CHECK_DIGITS_INDEX, :CHECK_BASE
end
