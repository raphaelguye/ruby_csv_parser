require 'spec_helper'
require 'csv'
require 'tempfile'
require_relative '../../module/parser'
require_relative '../../module/model/category'
require_relative '../../module/model/criteria'
require_relative '../../module/model/anomaly'
require_relative '../../module/model/analyse'

RSpec.describe 'parse' do
  let(:temp_csv) do
    Tempfile.new(['test', '.csv'])
  end

  let(:criteria) do
    [
      Criteria.new("Dance Figure", "DF", 2.3),
      Criteria.new("Choreography", "CO", 2.0)
    ]
  end

  let(:category) do
    Category.new("Test Category", criteria, "Test Group", [], [])
  end

  before do
    # Create a sample CSV with test data
    CSV.open(temp_csv.path, 'w') do |csv|
      csv << ["turnir", "Category", "Round", "Heat", "Stn", "Judge", "DF", "CO"]
      # Normal data (no anomalies)
      csv << ["Comp1", "Test Category", "Round1", "1", "1", "Judge1", "8.0", "7.5"]
      csv << ["Comp1", "Test Category", "Round1", "1", "1", "Judge2", "8.2", "7.6"]
      csv << ["Comp1", "Test Category", "Round1", "1", "1", "Judge3", "8.1", "7.7"]
      # Anomalous data (high standard deviation)
      csv << ["Comp1", "Test Category", "Round1", "2", "2", "Judge1", "8.0", "7.5"]
      csv << ["Comp1", "Test Category", "Round1", "2", "2", "Judge2", "8.2", "9.0"]
      csv << ["Comp1", "Test Category", "Round1", "2", "2", "Judge3", "8.1", "3.0"]
    end
  end

  after do
    temp_csv.unlink
  end

  it 'processes the CSV file and returns an Analysis object' do
    result = parse(temp_csv.path, [category], true, false)
    
    expect(result).to be_a(Analysis)
    expect(result.csv_content).to be_a(String)
    expect(result.anomalies).to be_a(Array)
    expect(result.number_of_analyses).to be > 0
  end

  it 'detects anomalies when standard deviation exceeds threshold' do
    result = parse(temp_csv.path, [category], true, false)
    
    # Should find anomalies for the second couple (station 2) due to high CO standard deviation
    co_anomalies = result.anomalies.select { |a| a.criteria == "CO" }
    expect(co_anomalies.size).to eq(1)
    
    anomaly = co_anomalies.first
    expect(anomaly.category).to eq("Test Category")
    expect(anomaly.group).to eq("Test Group")
    expect(anomaly.stdev_ratio).to be > 1.0
  end

  it 'does not detect anomalies when standard deviation is below threshold' do
    result = parse(temp_csv.path, [category], true, false)
    
    # Should not find anomalies for DF in any couple
    df_anomalies = result.anomalies.select { |a| a.criteria == "DF" }
    expect(df_anomalies).to be_empty
  end

  it 'respects the logAnomalies flag' do
    # Test with logAnomalies = false
    result = parse(temp_csv.path, [category], false, false)
    expect(result.anomalies.size).to eq(1) # Still detects anomalies, just doesn't log them
  end

  it 'respects the logSuccess flag' do
    # Test with logSuccess = true
    result = parse(temp_csv.path, [category], true, true)
    expect(result).to be_a(Analysis)
  end
end 