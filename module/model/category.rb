require './module/model/criteria.rb'

class Category < Struct.new(:name, :criterias, :group, :alias, :round_to_skip)
    def self.get_group(name)
        category = Categories::DANCE.find { |category| category.name == name }
        category ? category.group : "n/a"
    end
end

module Categories
    DANCE = [
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
    ].freeze

    ACRO = [
        Category.new("Rock'n'Roll-Main Class Start", $criterias_couples_acro, "Adults", [], []),
        Category.new("Rock'n'Roll-Main Class Contact Style", $criterias_couples_acro, "Adults", [], ["Final - Foot technique"]),
        Category.new("Rock'n'Roll-Main Class Free Style", $criterias_couples_acro, "Adults", [], ["Final - Foot technique"])
    ].freeze
end
