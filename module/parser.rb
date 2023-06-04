require 'csv'
require 'descriptive_statistics'

def parse(file, categories, logAnomalies = true, logSuccess = false)
    data = CSV.parse(File.read(file), headers: true)
    output = ""

    categories.each { |category| 

        rounds = data.uniq { |x| x["Round"] }.each { |roundRow|
            round = roundRow["Round"]

            all = data.filter { |x| x["Category"] == category.name && x["Round"] == round }
            next if all.empty?

            couples = all.uniq { |x| x["Stn"] }.each { |couple|

                category.criterias.each { |criteria| 

                    judges = all.filter { |x| x["Stn"] == couple["Stn"] }.uniq { |x| x["Judge"] }
                    samples = []
                    judges.each { |judge| 
                        samples.append(judge[criteria.abreviation].to_f)
                    }
                    stdev = samples.standard_deviation.round(2)

                    line = "#{category.name},#{round},#{couple["Heat"]},#{couple["Stn"]},#{criteria.abreviation},#{stdev},#{criteria.threshold},\"#{samples}\""
                    if stdev >= criteria.threshold
                        puts "⚠️,#{line}" unless !logAnomalies
                        line = "yes,#{line}"
                    else
                        puts "✅,#{line}" unless !logSuccess
                        line = ",#{line}"
                    end
                    output += line
                    output += "\n"
                }
            }
        }
    }
    return output
end
