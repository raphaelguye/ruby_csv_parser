require 'csv'
require 'descriptive_statistics'
require './module/model/anomaly.rb'
require './module/model/analyse.rb'

module Parser
  def self.parse(file, categories, log_anomalies = true, log_success = false)
    data = CSV.parse(File.read(file), headers: true)
    output = ""

    number_of_analyses = 0
    anomalies = []

    data.uniq { |x| x["turnir"] }.each { |competition|
      competition_id = competition["turnir"]
      categories.each { |category| 
        rounds = data.filter { |x| x["turnir"] == competition_id }.uniq { |x| x["Round"] }.each { |roundRow|
          round = roundRow["Round"]

          all = data.filter do |x|
            x["turnir"] == competition_id &&
            (x["Category"] == category.name || category.alias.include?(x["Category"])) &&
            x["Round"] == round
          end
          next if all.empty? || category.round_to_skip.include?(round)

          couples = all.uniq { |x| x["Stn"] }.each { |couple|
            category.criterias.each { |criteria|
              number_of_analyses += 1

              judges = all.filter { |x| x["Stn"] == couple["Stn"] }.uniq { |x| x["Judge"] }
              samples = []
              judges.each { |judge| 
                samples.append(judge[criteria.abreviation].to_f)
              }
              stdev = samples.standard_deviation.round(2)
              ratio = stdev/criteria.threshold

              line = "#{couple["turnir"]},#{category.name},#{round},#{couple["Heat"]},#{couple["Stn"]},#{criteria.abreviation},#{stdev},#{criteria.threshold},#{ratio},\"#{samples}\""
              if stdev >= criteria.threshold
                puts "⚠️,#{line}" unless !log_anomalies
                line = "yes,#{line}"

                criteria_to_report = ""
                if criteria.abreviation.include?("Acro")
                  criteria_to_report = "Acro"
                else
                  criteria_to_report = criteria.abreviation
                end
                raw_entry = "#{category.name},#{criteria.abreviation},#{round},Heat #{couple["Heat"]} Stn. #{couple["Stn"]},[#{samples.join(' ')}]\n"
                anomalies.append(Anomaly.new(criteria_to_report, category.name, category.group, ratio, raw_entry))
              else
                puts "✅,#{line}" unless !log_success
                line = ",#{line}"
              end
              output += line
              output += "\n"
            }
          }
        }
      }
    }
    Analysis.new(output, anomalies, number_of_analyses)
  end
end
