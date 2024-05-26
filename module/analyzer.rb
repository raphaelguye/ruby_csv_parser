require './module/model/anomaly.rb'

output = "todo"
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