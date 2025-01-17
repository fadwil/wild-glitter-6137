require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many :plots }
    it { should have_many(:plants).through(:plots) }
  end
  before do
    @brave = Garden.create!(name: "Brave Harvest", organic: true)
    @plot_1 = @brave.plots.create!(number: 1, size: "Medium", direction: "North")
    @plot_2 = @brave.plots.create!(number: 2, size: "Small", direction: "East")
    @tomato = Plant.create!(name: "Tomato", description: "Red", days_to_harvest: 40)
    @bell = Plant.create!(name: "Bell Pepper", description: "Tasty", days_to_harvest: 20)
    @eggplant = Plant.create!(name: "Eggplant", description: "Purple", days_to_harvest: 30)
    @artichoke = Plant.create!(name: "Artichoke", description: "Pointy", days_to_harvest: 120)
    @plant_plot_1 = PlantPlot.create!(plant: @tomato, plot: @plot_1)
    @plant_plot_2 = PlantPlot.create!(plant: @bell, plot: @plot_1)
    @plant_plot_3 = PlantPlot.create!(plant: @bell, plot: @plot_2)
    @plant_plot_4 = PlantPlot.create!(plant: @eggplant, plot: @plot_2)
    @plant_plot_4 = PlantPlot.create!(plant: @artichoke, plot: @plot_2)
  end

  describe "#instance methods" do
    describe "#unique_plants_under_100_days" do
      it "returns a list of plants unique to this garden that take less than 100 days to harvest" do
        unique_plants = @brave.unique_plants_under_100_days

        expect(unique_plants).to include(@tomato)
        expect(unique_plants).to include(@bell)
        expect(unique_plants).to include(@eggplant)
        expect(unique_plants).not_to include(@artichoke)
      end
    end
  end
end