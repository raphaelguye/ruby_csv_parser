require './module/category.rb'
require './module/parser.rb'

input_file_dance = "./src/2023-05-20_dance.csv"
input_file_acro = "./src/2023-05-20_acro.csv"
output_file = "./output/2023-05-20_report.csv"

content_dance = parse(input_file_dance, $categories_dance, false, false)
content_acro = parse(input_file_acro, $categories_acro, false, false)

content_csv = content_dance + content_acro

File.open(output_file, "w") { |f| 
    f.write("anomaly,category name,round,heat,couple,criteria,stdev,threshold,raw data\n")
    f.write(content_csv)
}

puts ""
puts "✅ #{output_file} created"
puts ""
