describe Post do
  subject { described_class.new }

  let(:author) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:valid_subject) do
    subject.author = author
    subject.title = 'Title'
    subject.body = 'Body'
    subject
  end
  let(:comments) {[Comment.new(body: "Comment 1", author: author), Comment.new(body: "Comment 2", author: author)]}
  let(:tags) {[Tag.new(name: "Tag 1"), Tag.new(name: "Tag 2")]}

  context "Validations" do 
    it "Post creation fails without required attributes" do
      assert subject.invalid?
      assert_empty subject.errors.map(&:attribute) - [:author, :user, :title, :body]
    end

    it "Post creation fails without author" do
      subject.title = 'Title'
      subject.body = 'Body'
      assert subject.invalid?
      assert_empty subject.errors.map(&:attribute) - [:author, :user]
    end
    
    it "Post creation fails without title" do
      subject.author = author
      subject.body = 'Body'
      assert subject.invalid?
      assert_empty subject.errors.map(&:attribute) - [:title]
    end
    
    it "Post creation fails without body" do
      subject.author = author
      subject.title = 'Title'
      assert subject.invalid?
      assert_empty subject.errors.map(&:attribute) - [:body]
    end

    it "Post creation succeeds" do
      assert valid_subject.valid?
      assert_empty valid_subject.errors
    end
  
    it "Post creation succeeds with tags" do
      valid_subject.tag_names_array = ["its a tag"]
      assert valid_subject.valid?
      assert_empty valid_subject.errors
    end
  end

  context "Associations" do 
    it "Post have an author which is same as its user" do
      assert valid_subject.valid?
      assert_equal valid_subject.user, valid_subject.author
    end

    it "Posts can have multiple comments" do
      valid_subject.comments << comments
      assert valid_subject.valid?
      assert_equal valid_subject.comments, comments
    end

    it "Posts can have multiple tags" do
      valid_subject.tags << tags
      assert valid_subject.valid?
      assert_equal valid_subject.tags, tags
      assert_equal valid_subject.tag_names_with_commas, tags.map(&:name).join(',')
    end
  end
end
