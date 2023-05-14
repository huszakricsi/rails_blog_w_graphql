describe Tag do
  subject { described_class.new }

  let(:valid_subject) do
    subject.name = "tag"
    subject
  end

  let(:author) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:post) { Post.new(author: author, title: 'Title', body: 'Body') }
  let(:other_post) { Post.new(author: author, title: 'Title 2', body: 'Body 2') }
  let(:tags) {[valid_subject, Tag.create(name: "tag2")]}

  context "Validations" do 
    it "Tag creation fails without name" do
      assert subject.invalid?
      assert_empty subject.errors.map(&:attribute) - [:name]
    end

    it "Tag creation fails if tag name is already taken" do
      assert Tag.create(name: "tag")
      subject.name = "tag"
      assert subject.invalid?
      assert_empty subject.errors.map(&:attribute) - [:name]
    end

    it "Tag creation succeeds" do
      assert valid_subject.valid?
      assert_empty valid_subject.errors
    end
  end

  context "Associations" do 
    it "Tag can belong to one post" do
      post.tags << valid_subject
      assert_equal post.tags, [valid_subject]
    end

    it "Tag can belong to multiple post" do
      post.tags << valid_subject
      other_post.tags << valid_subject
      assert_equal post.tags, other_post.tags
    end

    it "Multiple tags can belong to a post" do
      post.tags << tags
      assert_equal post.tags, tags
    end

    it "Multiple tags can belong to multiple posts" do
      post.tags << tags
      other_post.tags << tags
      assert_equal post.tags, other_post.tags
    end
  end
end
