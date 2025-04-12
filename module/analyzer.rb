require 'csv'
require './module/model/anomaly.rb'

module Analyzer
  def self.analyze_per_criteria(anomalies, number_of_analyses)
    criteria_counter = Hash.new(0)
    anomalies.each { |anomaly| criteria_counter[anomaly.criteria] += 1 }

    criteria_counter.map do |criteria, count|
      percentage = (100 * (count / number_of_analyses.to_f).round(2)).to_i
      AnalysisPerCriteria.new(criteria, count, number_of_analyses, percentage)
    end
  end

  def self.analyze_per_group(anomalies, content_csv)
    nb_entries_per_group = Hash.new(0).tap do |h|
      %w[Juniors Adults Formations].each { |group| h[group] = 0 }
    end

    # Count entries per group
    CSV.parse(content_csv, headers: false).each do |line|
      group = Category.get_group(line[2])
      nb_entries_per_group[group] += 1
    end

    # Count anomalies per group
    group_counter = Hash.new(0).tap do |h|
      %w[Juniors Adults Formations].each { |group| h[group] = 0 }
    end
    anomalies.each { |anomaly| group_counter[anomaly.group] += 1 }

    group_counter.map do |group, count|
      percentage = nb_entries_per_group[group] > 0 ? 
        (100 * (count / nb_entries_per_group[group].to_f).round(2)).to_i : 0
      AnalysisPerCriteria.new(group, count, nb_entries_per_group[group], percentage)
    end
  end
end