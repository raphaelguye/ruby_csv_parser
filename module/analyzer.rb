require 'csv'
require './module/model/anomaly.rb'

def analyzePerCriteria(anomalies,number_of_analyses)
    criteria_counter = Hash.new(0)
    anomalies.each do |anomaly|
        criteria_counter[anomaly.criteria] += 1
    end

    analysisPerCriteria = []
    criteria_counter.each do |criteria, count|
        percentage = (100 * (count / number_of_analyses.to_f).round(2)).to_i
        analysisPerCriteria.append(AnalysisPerCriteria.new(criteria, count, number_of_analyses, percentage))
    end      
    
    return analysisPerCriteria
end

def analyzePerGroup(anomalies,content_csv)
    nb_entries_per_group = Hash.new(0)
    nb_entries_per_group["Juniors"] = 0
    nb_entries_per_group["Adults"] = 0
    nb_entries_per_group["Formations"] = 0

    #TODO: implement nb_entries_per_group

    data = CSV.parse(content_csv, headers: false)
    data.each do |line|
        group = Category.get_group(line[1])
        nb_entries_per_group[group] += 1
    end

    puts nb_entries_per_group

    group_counter = Hash.new(0)
    group_counter["Juniors"] = 0
    group_counter["Adults"] = 0
    group_counter["Formations"] = 0
    anomalies.each do |anomaly|
        group_counter[anomaly.group] += 1
    end

    analysisPerGroup = []
    group_counter.each do |group, count|
        if nb_entries_per_group[group] > 0
            percentage = (100 * (count / nb_entries_per_group[group].to_f).round(2)).to_i
        else
            percentage = 0
        end
        analysisPerGroup.append(AnalysisPerCriteria.new(group, count, nb_entries_per_group[group], percentage))
    end      
    
    return analysisPerGroup
end