require "rails_helper"

RSpec.describe Event, type: :model do
  subject { event.valid? }

  let(:user) { create(:user) }
  let(:event) { build(:event, :with_creator) }

  describe "validations" do
    context "titleカラム" do
      it "空欄でないこと" do
        event.event_name = ""
        is_expected.to eq false
      end
      it "2文字以上であること: 1文字は×" do
        event.event_name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it "2文字以上であること: 2文字は〇" do
        event.event_name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
    end
  end
end
