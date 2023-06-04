require './module/model/criteria.rb'

Category = Struct.new(:name, :criterias, :group, :round_to_skip)

$categories_dance = [
    Category.new("Rock'n'Roll-Beginners", $criterias_couples_dance, "Juniors", []),
    Category.new("Rock'n'Roll-Juveniles", $criterias_couples_dance, "Juniors", []),
    Category.new("Rock'n'Roll-Juniors", $criterias_couples_dance, "Juniors", []),
    Category.new("Rock'n'Roll-Small Formations Juniors", $criterias_formations, "Formations", []),
    Category.new("Rock'n'Roll-Small Formations", $criterias_formations, "Formations", []),
    Category.new("Rock'n'Roll-Girl Formations", $criterias_formations, "Formations", []),
    Category.new("Rock'n'Roll-Ladies Formations", $criterias_formations, "Formations", []),
    Category.new("Rock'n'Roll-Main Class Start", $criterias_couples_dance, "Adults", []),
    Category.new("Rock'n'Roll-Main Class Contact Style", $criterias_couples_dance, "Adults", []),
    Category.new("Rock'n'Roll-Main Class Free Style", $criterias_couples_dance, "Adults", []),
]

$categories_acro = [
    Category.new("Rock'n'Roll-Main Class Start", $criterias_couples_acro, "Adults", []),
    Category.new("Rock'n'Roll-Main Class Contact Style", $criterias_couples_acro, "Adults", ["Final - Foot technique"]),
    Category.new("Rock'n'Roll-Main Class Free Style", $criterias_couples_acro, "Adults", ["Final - Foot technique"]),
]
