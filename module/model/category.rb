require './module/model/criteria.rb'

Category = Struct.new(:name, :criterias, :group, :alias, :round_to_skip) do
    def self.get_group(name)
        category = $categories_dance.find { |category| category.name == name }
        category ? category.group : "n/a"
    end
end

$categories_dance = [
    Category.new("Rock'n'Roll-Beginners", $criterias_couples_dance, "Juniors", [], []),
    Category.new("Rock'n'Roll-Juveniles", $criterias_couples_dance, "Juniors", [], []),
    Category.new("Rock'n'Roll-Juniors", $criterias_couples_dance, "Juniors", [], []),
    Category.new("Rock'n'Roll-Small Formation Juniors", $criterias_formations, "Formations", ["Rock'n'Roll-Small Formations Juniors"], []),
    Category.new("Rock'n'Roll-Small Formation", $criterias_formations, "Formations", ["Rock'n'Roll-Small Formations"], []),
    Category.new("Rock'n'Roll-Formation Juniors", $criterias_formations, "Formations", ["Rock'n'Roll-Girl Formations"], []),
    Category.new("Rock'n'Roll-Formation", $criterias_formations, "Formations", ["Rock'n'Roll-Ladies Formations"], []),
    Category.new("Rock'n'Roll-Main Class Start", $criterias_couples_dance, "Adults", [], []),
    Category.new("Rock'n'Roll-Main Class Contact Style", $criterias_couples_dance, "Adults", [], []),
    Category.new("Rock'n'Roll-Main Class Free Style", $criterias_couples_dance, "Adults", [], [])
]

$categories_acro = [
    Category.new("Rock'n'Roll-Main Class Start", $criterias_couples_acro, "Adults", [], []),
    Category.new("Rock'n'Roll-Main Class Contact Style", $criterias_couples_acro, "Adults", [], ["Final - Foot technique"]),
    Category.new("Rock'n'Roll-Main Class Free Style", $criterias_couples_acro, "Adults", [], ["Final - Foot technique"])
]
