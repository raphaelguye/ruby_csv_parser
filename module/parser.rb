require 'csv'
require 'descriptive_statistics'
require './module/model/anomaly.rb'
require './module/model/analyse.rb'

def parse(file, categories, logAnomalies = true, logSuccess = false)
    data = CSV.parse(File.read(file), headers: true)
    output = ""

    heats_number = 0
    anomalies = []

    categories.each { |category| 

        rounds = data.uniq { |x| x["Round"] }.each { |roundRow|
            round = roundRow["Round"]

            all = data.filter { |x| x["Category"] == category.name && x["Round"] == round }
            next if all.empty? || category.round_to_skip.include?(round)

            couples = all.uniq { |x| x["Stn"] }.each { |couple|

                heats_number += 1

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

                        criteria_to_report = ""
                        if criteria.abreviation.include?("Acro")
                            criteria_to_report = "Acro"
                        else
                            criteria_to_report = criteria.abreviation
                        end
                        anomalies.append(Anomaly.new(criteria_to_report, category.name, category.group))
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
    return Analyse.new(output, anomalies, heats_number)
end
