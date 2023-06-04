require './module/category.rb'
require './module/parser.rb'
require './module/anomaly.rb'
require './module/analyse.rb'

input_file_dance = "./src/2023-04-22_dance.csv"
input_file_acro = "./src/2023-04-22_acro.csv"
output_file = "./output/2023-04-22_report.csv"

analyse_dance = parse(input_file_dance, $categories_dance, false, false)
analyse_acro = parse(input_file_acro, $categories_acro, false, false)

content_csv = analyse_dance.csv_content + analyse_acro.csv_content

# puts analyse_dance.heats_number
# puts analyse_dance.anomalies

# puts analyse_acro.heats_number
# puts analyse_acro.anomalies

File.open(output_file, "w") { |f| 
    f.write("anomaly,category name,round,heat,couple,criteria,stdev,threshold,raw data\n")
    f.write(content_csv)
}

puts ""
puts "✅ #{output_file} created"
puts ""
