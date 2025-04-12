require 'spec_helper'
require 'csv'
require_relative '../../module/analyzer'
require_relative '../../module/model/anomaly'
require_relative '../../module/model/analyse'
require_relative '../../module/model/category'

RSpec.describe 'Analyzer' do
  describe '#analyzePerCriteria' do
    let(:anomalies) do
      [
        Anomaly.new("CO", "Category1", "Adults", 1.5, "raw1"),
        Anomaly.new("CO", "Category2", "Adults", 1.2, "raw2"),
        Anomaly.new("DF", "Category1", "Adults", 1.3, "raw3"),
        Anomaly.new("Acro", "Category3", "Adults", 1.4, "raw4"),
        Anomaly.new("Acro", "Category4", "Adults", 1.6, "raw5")
      ]
    end

    let(:number_of_analyses) { 100 }  # Total number of analyses performed

    it 'correctly counts anomalies per criteria' do
      result = analyzePerCriteria(anomalies, number_of_analyses)
      
      expect(result).to be_an(Array)
      expect(result.size).to eq(3)  # Should have results for CO, DF, and Acro

      co_analysis = result.find { |a| a.criteria == "CO" }
      df_analysis = result.find { |a| a.criteria == "DF" }
      acro_analysis = result.find { |a| a.criteria == "Acro" }

      expect(co_analysis.counter).to eq(2)
      expect(df_analysis.counter).to eq(1)
      expect(acro_analysis.counter).to eq(2)
    end

    it 'calculates correct percentages' do
      result = analyzePerCriteria(anomalies, number_of_analyses)
      
      co_analysis = result.find { |a| a.criteria == "CO" }
      expect(co_analysis.percentage).to eq(2)  # (2/100) * 100 = 2%
      
      df_analysis = result.find { |a| a.criteria == "DF" }
      expect(df_analysis.percentage).to eq(1)  # (1/100) * 100 = 1%
    end

    it 'handles empty anomalies list' do
      result = analyzePerCriteria([], number_of_analyses)
      expect(result).to be_empty
    end
  end

  describe '#analyzePerGroup' do
    let(:anomalies) do
      [
        Anomaly.new("CO", "Category1", "Adults", 1.5, "raw1"),
        Anomaly.new("CO", "Category2", "Adults", 1.2, "raw2"),
        Anomaly.new("DF", "Category3", "Juniors", 1.3, "raw3"),
        Anomaly.new("Acro", "Category4", "Formations", 1.4, "raw4")
      ]
    end

    let(:csv_content) do
      <<~CSV
        turnir,name,Rock'n'Roll-Main Class Start,round,heat,judge,score
        1,Test1,Rock'n'Roll-Main Class Start,1,1,J1,8.0
        2,Test2,Rock'n'Roll-Main Class Start,1,1,J2,8.5
        3,Test3,Rock'n'Roll-Juniors,1,1,J1,7.5
        4,Test4,Rock'n'Roll-Formation,1,1,J2,9.0
      CSV
    end

    it 'correctly counts anomalies per group' do
      result = analyzePerGroup(anomalies, csv_content)
      
      expect(result).to be_an(Array)
      expect(result.size).to eq(3)  # Should have results for all three groups

      adults = result.find { |a| a.criteria == "Adults" }
      juniors = result.find { |a| a.criteria == "Juniors" }
      formations = result.find { |a| a.criteria == "Formations" }

      expect(adults.counter).to eq(2)
      expect(juniors.counter).to eq(1)
      expect(formations.counter).to eq(1)
    end

    it 'calculates percentages based on total entries per group' do
      result = analyzePerGroup(anomalies, csv_content)
      
      adults = result.find { |a| a.criteria == "Adults" }
      expect(adults.number_of_analyses).to be > 0
      expect(adults.percentage).to be_a(Integer)
    end

    it 'handles groups with no entries' do
      # Create CSV with no entries for a particular group
      empty_group_csv = <<~CSV
        turnir,name,Rock'n'Roll-Main Class Start,round,heat,judge,score
        1,Test1,Rock'n'Roll-Main Class Start,1,1,J1,8.0
      CSV

      result = analyzePerGroup(anomalies, empty_group_csv)
      
      formations = result.find { |a| a.criteria == "Formations" }
      expect(formations.percentage).to eq(0)
    end

    it 'handles empty anomalies list' do
      result = analyzePerGroup([], csv_content)
      
      expect(result).to be_an(Array)
      expect(result.size).to eq(3)  # Should still return all groups
      result.each do |group_analysis|
        expect(group_analysis.counter).to eq(0)
      end
    end
  end
end 