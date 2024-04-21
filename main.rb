require './module/model/category.rb'
require './module/model/anomaly.rb'
require './module/model/analyse.rb'
require './module/parser.rb'
require './module/analyzer.rb'

input_file_dance = "./src/2024-04-20_mcs_dance.csv"
input_file_acro = "./src/2024-04-20_mcs_acro.csv"
output_file_report = "./output/2024-04-20_mcs_report.csv"
output_file_summary = "./output/2024-04-20_mcs_summary.csv"

analyse_dance = parse(input_file_dance, $categories_dance, false, false)
analyse_acro = parse(input_file_acro, $categories_acro, false, false)

content_csv = analyse_dance.csv_content + analyse_acro.csv_content

File.open(output_file_report, "w") { |f| 
    f.write("anomaly,category name,round,heat,couple,criteria,stdev,threshold,raw data\n")
    f.write(content_csv)
}

puts ""
puts "✅ #{output_file_report} created"
puts ""

#TODO: summary = analyzer(analyse_dance, analyse_acro)

percentage_anomalies_dance = (analyse_dance.anomalies.count/analyse_dance.heats_number.to_f).round(2)
percentage_anomalies_acro = (analyse_acro.anomalies.count/analyse_acro.heats_number.to_f).round(2)

File.open(output_file_summary, "w") { |f| 
    f.write("Summary\n\n")
    f.write("Part,nb of anomalies, nb of heats,percentage of anomalie\n")
    f.write("Dance,#{analyse_dance.anomalies.count},#{analyse_dance.heats_number},#{percentage_anomalies_dance}\n")
    f.write("Acro,#{analyse_acro.anomalies.count},#{analyse_acro.heats_number},#{percentage_anomalies_acro}\n")
}

puts ""
puts "✅ #{output_file_summary} created"
puts ""