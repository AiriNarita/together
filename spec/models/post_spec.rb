require "rails_helper"

RSpec.describe Post, type: :model do
  subject { post.valid? }
  # Factoryでデータを作る
  let(:user) { create(:user) }
  let(:post) { build(:post, user_id: user.id) }

  # 参考
  # https://qiita.com/jnchito/items/42193d066bd61c740612
  # https://qiita.com/jnchito/items/2a5d3e15761fd413657a
  # https://qiita.com/jnchito/items/3ef95ea144ed15df3637
  it "テスト用のUserやPostが存在するか（Factoryでちゃんと作られたか確認" do
    expect(user).to be_valid
    expect(post).to be_valid
  end

  context "titleカラム" do
    it "空欄でないこと" do
      post.title = ""
      is_expected.to eq false
    end
    it "2文字以上であること: 1文字は×" do
      post.title = Faker::Lorem.characters(number: 1)
      is_expected.to eq false
    end
    it "2文字以上であること: 2文字は〇" do
      post.title = Faker::Lorem.characters(number: 2)
      is_expected.to eq true
    end
  end

  describe "Accociations" do
    it "PostはUserが一つのみ (belongs_to test)" do
      t = Post.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end

    it "PostはPost Commentが複数(has_many test)" do
      t = Post.reflect_on_association(:post_comments)
      expect(t.macro).to eq(:has_many)
    end
  end

  describe "Instance methods" do
    describe "#save_draft" do
      it "saves the post as draft" do
        post.update(post_status: :published)
        post.save_draft
        expect(post.reload.post_status).to eq("draft")
      end
    end
  end

  describe "Scopes" do
    describe ".published" do
      let!(:published_post) { create(:post, post_status: :published) }
      let!(:draft_post) { create(:post, post_status: :draft) }

      it "returns published posts" do
        expect(Post.published).to eq([published_post])
      end
    end

    describe ".by_active_users" do
      let!(:active_user) { create(:user, user_status: 0) }
      let!(:inactive_user) { create(:user, user_status: 1) }
      let!(:active_user_post) { create(:post, user: active_user) }
      let!(:inactive_user_post) { create(:post, user: inactive_user) }

      it "returns posts by active users" do
        expect(Post.by_active_users).to eq([active_user_post])
      end
    end

    describe ".visible" do
      let!(:visible_post) { create(:post, post_status: :published, user: create(:user, user_status: 0)) }
      let!(:invisible_post1) { create(:post, post_status: :draft, user: create(:user, user_status: 0)) }
      let!(:invisible_post2) { create(:post, post_status: :published, user: create(:user, user_status: 1)) }

      it "returns visible posts" do
        expect(Post.visible).to eq([visible_post])
      end
    end
  end
end
