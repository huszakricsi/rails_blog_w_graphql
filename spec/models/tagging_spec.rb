describe Tagging do
  subject { described_class.new }

  let(:valid_subject) do
    subject.tag = tag
    subject.post = post
    subject
  end
  let(:invalid_subject) {Tagging.new(tag: tag, post: post)}
  let(:tag) {Tag.new(name: "Tag")}
  let(:author) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:post) { Post.new(author: author, title: 'Title', body: 'Body') }

  context "Validations" do 
    it "Tag and post connections should be unique" do
      assert valid_subject.save
      assert invalid_subject.invalid?
      assert_empty invalid_subject.errors.map(&:attribute) - [:tag]
    end

    it "Tag and post connects via tagging" do
      assert valid_subject.save
      assert_empty valid_subject.errors
      assert_equal valid_subject.post, post
      assert_equal valid_subject.tag, tag
    end

  end

  context "Associations" do 
    it "Belongs to a tag and a post" do
      assert valid_subject.save
      assert_equal post, valid_subject.post
      assert_equal tag, valid_subject.tag
    end
  end
end
