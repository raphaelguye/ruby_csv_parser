require 'csv'
require 'descriptive_statistics'

input_file = "./src/2023-05-20_acro.csv"

Criteria = Struct.new(:name, :abreviation, :threshold)
Category = Struct.new(:name, :criterias)

threshold_reference = 12.0
threshold_mistakes_reference = 4.0

criterias_acros = [
    Criteria.new("Acro 1", "Acro 1", threshold_reference), 
    Criteria.new("Acro 2", "Acro 2", threshold_reference), 
    Criteria.new("Acro 3", "Acro 3", threshold_reference), 
    Criteria.new("Acro 4", "Acro 4", threshold_reference), 
    Criteria.new("Acro 5", "Acro 5", threshold_reference), 
    Criteria.new("Acro 6", "Acro 6", threshold_reference), 
    Criteria.new("Fall", "fall", threshold_mistakes_reference),
    Criteria.new("Big mistake", "bm", threshold_mistakes_reference),
]

criterias_mcs = criterias_acros
criterias_mccs = criterias_acros
criterias_mcfs = criterias_acros

data = CSV.parse(File.read(input_file), headers: true)

# puts data

categories = [
    Category.new("Rock'n'Roll-Main Class Start", criterias_mcs),
    Category.new("Rock'n'Roll-Main Class Contact Style", criterias_mccs),
    Category.new("Rock'n'Roll-Main Class Free Style", criterias_mcfs),
]

categories.each { |category| 

    rounds = data.uniq { |x| x["Round"] }.each { |roundRow|
        round = roundRow["Round"]

        all = data.filter { |x| x["Category"] == category.name && x["Round"] == round }
        next if all.empty?

        puts ""
        puts "#{category.name} - #{round}"
        puts "\t\tCouple\tHeat\tCrit.\tStdev\tRaw"
        puts "\t\t======\t====\t=====\t=====\t==="

        is_category_confirmed = false
        couples = all.uniq { |x| x["Stn"] }.each { |couple|

            category.criterias.each { |criteria| 

                judges = all.filter { |x| x["Stn"] == couple["Stn"] }.uniq { |x| x["Judge"] }
                samples = []
                judges.each { |judge| 
                    samples.append(judge[criteria.abreviation].to_f)
                }
                stdev = samples.standard_deviation.round(2)

                if stdev >= criteria.threshold
                    puts "\t⚠️\t#{couple["Stn"]}\t#{couple["Heat"]}\t#{criteria.abreviation}\t#{stdev}\t#{samples}"
                    is_category_confirmed = true
                # else 
                #     puts "\t✅\t#{couple["Stn"]}\t#{couple["Heat"]}\t#{criteria.abreviation}\t#{stdev}\t#{samples}"
                #     is_category_confirmed = true
                end
            }
        }
        # puts "\t✅" unless is_category_confirmed
    }    
}
