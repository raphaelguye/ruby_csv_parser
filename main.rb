require './module/model/category.rb'
require './module/model/anomaly.rb'
require './module/model/analyse.rb'
require './module/parser.rb'
require './module/analyzer.rb'
require './module/utils/translator.rb'

INPUT_FOLDER  = "./src/2024"
OUTPUT_FOLDER = "./output/2024"

# Collect acro and dance files
acro_files  = Dir.glob(File.join(INPUT_FOLDER, "*_acro.csv"))
dance_files = Dir.glob(File.join(INPUT_FOLDER, "*_dance.csv"))

# Extract prefixes (i.e., remove '_acro.csv' or '_dance.csv')
acro_prefixes  = acro_files.map  { |f| File.basename(f, '_acro.csv') }
dance_prefixes = dance_files.map { |f| File.basename(f, '_dance.csv') }

# Find missing matches
acro_only_prefixes  = acro_prefixes  - dance_prefixes  # no matching dance
dance_only_prefixes = dance_prefixes - acro_prefixes   # no matching acro

acro_only_prefixes.each do |prefix|
  puts "❌ No matching _dance file found for prefix: #{prefix}"
end
dance_only_prefixes.each do |prefix|
  puts "❌ No matching _acro file found for prefix: #{prefix}"
end
puts ""

# Loop over valid pairs of _acro and _dance files found
valid_prefixes = acro_prefixes & dance_prefixes
valid_prefixes.each do |base_prefix|
  acro_file  = File.join(INPUT_FOLDER, "#{base_prefix}_acro.csv")
  dance_file = File.join(INPUT_FOLDER, "#{base_prefix}_dance.csv")

  # Parse
  analysis_acro  = parse(acro_file,  $categories_acro,  false, false)
  analysis_dance = parse(dance_file, $categories_dance, false, false)

  # Combine CSV
  content_csv = analysis_dance.csv_content + analysis_acro.csv_content

  # Write report
  output_file_report  = File.join(OUTPUT_FOLDER, "#{base_prefix}_report.csv")
  File.open(output_file_report, "w") do |f|
    f.write("anomaly,competition,category name,round,heat,couple,criteria,stdev,threshold,ratio,raw data\n")
    f.write(content_csv)
  end
  puts "✅ Created: #{output_file_report}"

  # Calculate anomalies and percentages
  percentage_anomalies_acro  = (100 * (analysis_acro.anomalies.count  / analysis_acro.number_of_analyses.to_f).round(2)).to_i
  percentage_anomalies_dance = (100 * (analysis_dance.anomalies.count / analysis_dance.number_of_analyses.to_f).round(2)).to_i

  danceAnalysisPerCriteria = analyzePerCriteria(
    analysis_dance.anomalies,
    analysis_dance.number_of_analyses / $criterias_couples_dance.count
  )
  acroAnalysisPerCriteria  = analyzePerCriteria(
    analysis_acro.anomalies,
    analysis_acro.number_of_analyses
  )
  combinedAnalysisPerCriteria = danceAnalysisPerCriteria + acroAnalysisPerCriteria
  sorted_analysis_per_criteria = combinedAnalysisPerCriteria.sort_by { |analysis| -analysis.percentage }

  all_anomalies = analysis_acro.anomalies + analysis_dance.anomalies
  analysisPerGroup = analyzePerGroup(all_anomalies, content_csv)
  sorted_analysis_per_group = analysisPerGroup.sort_by { |analysis| -analysis.percentage }

  # Only compute Top 5 anomalies if *not* "overall"
  top_anomalies = []
  compute_top_anomalies = !base_prefix.downcase.include?("overall")
  if compute_top_anomalies
    sorted_anomalies = all_anomalies.sort_by { |anomaly| -anomaly.stdev_ratio }
    top_anomalies    = sorted_anomalies.first(5)
  end

  output_file_summary = File.join(OUTPUT_FOLDER, "#{base_prefix}_summary.csv")
  File.open(output_file_summary, "w") do |f|
    f.write("Summary\n\n")

    f.write("Number of anomalies per part,nb of anomalies, nb of analysis made,percentage of anomalies\n")
    f.write("Dancing part,#{analysis_dance.anomalies.count},#{analysis_dance.number_of_analyses},#{percentage_anomalies_dance}%\n")
    f.write("Acrobatic part,#{analysis_acro.anomalies.count},#{analysis_acro.number_of_analyses},#{percentage_anomalies_acro}%\n\n")

    f.write("Number of anomalies per criteria,nb of anomalies, nb of analysis made,percentage of anomalies\n")
    sorted_analysis_per_criteria.each do |analysisPerCriteria|
      translated_criteria = Translator.translate(analysisPerCriteria.criteria)
      f.write("#{translated_criteria},#{analysisPerCriteria.counter},#{analysisPerCriteria.number_of_analyses},#{analysisPerCriteria.percentage}%\n")
    end
    f.write("\n")

    f.write("Number of anomalies per group,nb of anomalies, nb of analysis made,percentage of anomalies\n")
    sorted_analysis_per_group.each do |analysisPerGroup|
      translated_criteria = Translator.translate(analysisPerGroup.criteria)
      f.write("#{translated_criteria},#{analysisPerGroup.counter},#{analysisPerGroup.number_of_analyses},#{analysisPerGroup.percentage}%\n")
    end
    f.write("\n")

    # Only write out the "Top 5 anomalies" section if it's not "overall"
    unless base_prefix.downcase.include?("overall")
      f.write("Top 5 anomalies\n")
      top_anomalies.each do |anomaly|
        f.write(anomaly.raw_entry)
      end
      f.write("\n")
    end
  end

  puts "✅ Created: #{output_file_summary}"
  puts ""
end