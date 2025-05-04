Criteria = Struct.new(:name, :abreviation, :threshold)

criteria_df = 2.3
criteria_cdp = 2.0
criteria_fm = 2.0
criteria_fw = 14.4
criteria_sm = 2.3
criteria_bm = 8.0
criteria_acro = 12.0

$criterias_formations = [
    Criteria.new("Dance Figure", "DF", criteria_df),
    Criteria.new("Choreography", "CO", criteria_cdp),
    Criteria.new("FM?", "FM", criteria_fm),
    Criteria.new("FW?", "FW", criteria_fw),
    Criteria.new("Small mistakes", "sm", criteria_sm),
    Criteria.new("Big mistakes", "bm", criteria_bm),
]

$criterias_couples_dance = [
    Criteria.new("Dance Figure", "DF", criteria_df), 
    Criteria.new("Choreography", "CO", criteria_cdp), 
    Criteria.new("Foot Man", "FM", criteria_fm), 
    Criteria.new("Foot Woman", "FW", criteria_fw), 
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
