Analysis = Struct.new(:csv_content, :anomalies, :number_of_analyses)

AnalysisPerCriteria = Struct.new(:criteria, :counter, :number_of_analyses, :percentage)