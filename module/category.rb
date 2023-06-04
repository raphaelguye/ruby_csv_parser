require './module/criteria.rb'

Category = Struct.new(:name, :criterias)

$categories_dance = [
    Category.new("Rock'n'Roll-Beginners", $criterias_couples_dance),
    Category.new("Rock'n'Roll-Juveniles", $criterias_couples_dance),
    Category.new("Rock'n'Roll-Juniors", $criterias_couples_dance),
    Category.new("Rock'n'Roll-Small Formations Juniors", $criterias_formations),
    Category.new("Rock'n'Roll-Small Formations", $criterias_formations),
    Category.new("Rock'n'Roll-Girl Formations", $criterias_formations),
    Category.new("Rock'n'Roll-Ladies Formations", $criterias_formations),
    Category.new("Rock'n'Roll-Main Class Start", $criterias_couples_dance),
    Category.new("Rock'n'Roll-Main Class Contact Style", $criterias_couples_dance),
    Category.new("Rock'n'Roll-Main Class Free Style", $criterias_couples_dance),
]

$categories_acro = [
    Category.new("Rock'n'Roll-Main Class Start", $criterias_couples_acro),
    Category.new("Rock'n'Roll-Main Class Contact Style", $criterias_couples_acro),
    Category.new("Rock'n'Roll-Main Class Free Style", $criterias_couples_acro),
]
