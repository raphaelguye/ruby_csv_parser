Criteria = Struct.new(:name, :abreviation, :threshold)

criteria_df = 2.0
criteria_co = 2.0
criteria_fm = 1.6
criteria_fw = -1
criteria_sm = 2.3
criteria_bm = 3.0
criteria_acro = 12.0
criteria_fall = 3.0

$criterias_formations = [
    Criteria.new("Dance Figure", "DF", criteria_df),
    Criteria.new("Choreography", "CO", criteria_co),
    Criteria.new("?", "FM", criteria_fm),
    # Criteria.new("?", "FM", 1.6),
    Criteria.new("Small mistakes", "sm", criteria_sm),
    Criteria.new("Big mistakes", "bm", criteria_bm),
]

$criterias_couples_dance = [
    Criteria.new("Dance Figure", "DF", criteria_df), 
    Criteria.new("Choreography", "CO", criteria_co), 
    Criteria.new("Foot Man", "FM", criteria_fm), 
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
    Criteria.new("Fall", "fall", criteria_fall),
    Criteria.new("Big mistake", "bm", criteria_bm),
]
