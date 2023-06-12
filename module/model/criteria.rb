Criteria = Struct.new(:name, :abreviation, :threshold)

criteria_rr_df = 2.0
criteria_rr_co = 2.0
criteria_rr_fm = 1.6
criteria_rr_fw = -1
criteria_rr_sm = 2.3
criteria_rr_bm = 3.0
criteria_rr_acro = 12.0
criteria_rr_fall = 3.0
criteria_bw_bbw = 1.5
criteria_bw_bbm = 1.5
criteria_bw_lf = 1.5
criteria_bw_df = 1.5
criteria_bw_mi = 1.5

$criterias_formations = [
    Criteria.new("Dance Figure", "DF", criteria_rr_df),
    Criteria.new("Choreography", "CO", criteria_rr_co),
    Criteria.new("?", "FM", criteria_rr_fm),
    # Criteria.new("?", "FM", 1.6),
    Criteria.new("Small mistakes", "sm", criteria_rr_sm),
    Criteria.new("Big mistakes", "bm", criteria_rr_bm),
]

$criterias_couples_dance = [
    Criteria.new("Dance Figure", "DF", criteria_rr_df), 
    Criteria.new("Choreography", "CO", criteria_rr_co), 
    Criteria.new("Foot Man", "FM", criteria_rr_fm), 
    Criteria.new("Small mistakes", "sm", criteria_rr_sm),
    Criteria.new("Big mistakes", "bm", criteria_rr_bm),
	Criteria.new("Boogie Basic Man", "BBW", criteria_bw_bbw), 
    Criteria.new("Boogie Basic Woman", "BBM", criteria_bw_bbm), 
    Criteria.new("Lead & Follow", "LF", criteria_bw_lf), 
    Criteria.new("Dance Figures", "DF", criteria_bw_df),
    Criteria.new("Music Interpretation", "MI", criteria_bw_mi),
]

$criterias_couples_acro = [
    Criteria.new("Acro 1", "Acro 1", criteria_rr_acro), 
    Criteria.new("Acro 2", "Acro 2", criteria_rr_acro), 
    Criteria.new("Acro 3", "Acro 3", criteria_rr_acro), 
    Criteria.new("Acro 4", "Acro 4", criteria_rr_acro), 
    Criteria.new("Acro 5", "Acro 5", criteria_rr_acro), 
    Criteria.new("Acro 6", "Acro 6", criteria_rr_acro), 
    Criteria.new("Fall", "fall", criteria_rr_fall),
    Criteria.new("Big mistake", "bm", criteria_rr_bm),
]
