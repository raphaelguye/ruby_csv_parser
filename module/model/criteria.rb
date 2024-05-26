Criteria = Struct.new(:name, :abreviation, :threshold)

criteria_df = 2.0
criteria_cdp = 2.0
criteria_fm = 12.0
criteria_fw = 12.0
criteria_sm = 2.3
criteria_bm = 3.0
criteria_acro = 12.0

$criterias_formations = [
    Criteria.new("Dance Figure", "DF1", criteria_df),
    Criteria.new("Choreography", "CDP1", criteria_cdp),
    Criteria.new("?", "FWM1", criteria_fm),
    Criteria.new("?", "FWL1", criteria_fw),
    Criteria.new("Small mistakes", "sm", criteria_sm),
    Criteria.new("Big mistakes", "bm", criteria_bm),
]

$criterias_couples_dance = [
    Criteria.new("Dance Figure", "DF1", criteria_df), 
    Criteria.new("Choreography", "CDP1", criteria_cdp), 
    Criteria.new("Foot Man", "FWM1", criteria_fm), 
    Criteria.new("Foot Man", "FWL1", criteria_fw), 
    Criteria.new("Small mistakes", "sm", criteria_sm),
    Criteria.new("Big mistakes", "bm", criteria_bm),
]

$criterias_couples_acro = [
    Criteria.new("Acro 1", "Acro 1", criteria_acro), 
    Criteria.new("Acro 2", "Acro 2", criteria_acro), 
    Criteria.new("Acro 3", "Acro 3", criteria_acro), 
    Criteria.new("Acro 4", "Acro 4", criteria_acro), 
    Criteria.new("Acro 5", "Acro 5", criteria_acro), 
    Criteria.new("Acro 6", "Acro 6", criteria_acro), 
]
