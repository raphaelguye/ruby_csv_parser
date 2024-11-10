require './module/model/category.rb'
require './module/model/anomaly.rb'
require './module/model/analyse.rb'
require './module/parser.rb'
require './module/analyzer.rb'
require './module/utils/translator.rb'

input_file_dance = "./src/2024-11-02_dance.csv"
input_file_acro = "./src/2024-11-02_acro.csv"
output_file_report = "./output/2024-11-02_report.csv"
output_file_summary = "./output/2024-11-02_summary.csv"

analysis_dance = parse(input_file_dance, $categories_dance, false, false)
analysis_acro = parse(input_file_acro, $categories_acro, false, false)

content_csv = analysis_dance.csv_content + analysis_acro.csv_content

File.open(output_file_report, "w") { |f| 
    f.write("anomaly,category name,round,heat,couple,criteria,stdev,threshold,ratio,raw data\n")
    f.write(content_csv)
}

puts ""
puts "✅ #{output_file_report} created"
puts ""

percentage_anomalies_dance = (100*(analysis_dance.anomalies.count/analysis_dance.number_of_analyses.to_f).round(2)).to_i
percentage_anomalies_acro = (100*(analysis_acro.anomalies.count/analysis_acro.number_of_analyses.to_f).round(2)).to_i

danceAnalysisPerCriteria = analyzePerCriteria(analysis_dance.anomalies,analysis_dance.number_of_analyses/$criterias_couples_dance.count)
acroAnalysisPerCriteria = analyzePerCriteria(analysis_acro.anomalies,analysis_acro.number_of_analyses)
combinedAnalysisPerCriteria = danceAnalysisPerCriteria + acroAnalysisPerCriteria
sorted_analysis_per_criteria = combinedAnalysisPerCriteria.sort_by { |analysis| -analysis.percentage }

allAnomalies = analysis_acro.anomalies + analysis_dance.anomalies
analysisPerGroup = analyzePerGroup(allAnomalies, content_csv)
sorted_analysis_per_group = analysisPerGroup.sort_by { |analysis| -analysis.percentage }

sorted_anomalies = allAnomalies.sort_by { |anomaly| -anomaly.stdev_ratio }
top_anomalies = sorted_anomalies.first(5)

File.open(output_file_summary, "w") { |f| 
    f.write("Summary")
    f.write("\n")
    f.write("\n")

    f.write("Number of anomalies per part,nb of anomalies, nb of analysis made,percentage of anomalies\n")
    f.write("Dancing part,#{analysis_dance.anomalies.count},#{analysis_dance.number_of_analyses},#{percentage_anomalies_dance}%\n")
    f.write("Acrobatic part,#{analysis_acro.anomalies.count},#{analysis_acro.number_of_analyses},#{percentage_anomalies_acro}%\n")
    f.write("\n")

    f.write("Number of anomalies per criteria,nb of anomalies, nb of analysis made,percentage of anomalies\n")
    sorted_analysis_per_criteria.each .each do |analysisPerCriteria|
        translated_criteria = Translator.translate(analysisPerCriteria.criteria)
        f.write("#{translated_criteria},#{analysisPerCriteria.counter},#{analysisPerCriteria.number_of_analyses},#{analysisPerCriteria.percentage}%\n")
    end
    f.write("\n")

    f.write("Number of anomalies per group,nb of anomalies, nb of analysis made,percentage of anomalies\n")
    sorted_analysis_per_group.each .each do |analysisPerGroup|
        translated_criteria = Translator.translate(analysisPerGroup.criteria)
        f.write("#{translated_criteria},#{analysisPerGroup.counter},#{analysisPerGroup.number_of_analyses},#{analysisPerGroup.percentage}%\n")
    end
    f.write("\n")

    f.write("Top 5 anomalies\n")
    top_anomalies.each do |anomaly|
        f.write(anomaly.raw_entry)
    end
    f.write("\n")
}

puts ""
puts "✅ #{output_file_summary} created"
puts ""