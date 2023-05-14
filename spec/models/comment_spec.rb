describe Comment do
  subject { described_class.new }

  let(:valid_subject) do
    subject.body = "Comment.."
    subject.author = author
    subject.post = post
    subject
  end
  let(:author) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:post) { Post.new(author: author, title: 'Title', body: 'Body') }

  context "Validations" do 
    it "Comment creation fails without body" do
      subject.author = author
      subject.post = post
      assert subject.invalid?
      assert_empty subject.errors.map(&:attribute) - [:body]
    end

    it "Comment creation fails without author" do
      subject.body = "Comment.."
      subject.post = post
      assert subject.invalid?
      assert_empty subject.errors.map(&:attribute) - [:author, :user]
    end
    
    it "Comment creation fails without post" do
      subject.body = "Comment.."
      subject.author = author
      assert subject.invalid?
      assert_empty subject.errors.map(&:attribute) - [:post]
    end 

    it "Comment creation succeeds" do
      assert valid_subject.valid?
      assert_empty valid_subject.errors
    end
  end

  context "Associations" do 
    it "Comments belongs to an author which is same to a user" do
      assert_equal valid_subject.author, valid_subject.user
      assert_equal valid_subject.author, author
    end

    it "Comments belongs to a post" do
      assert_equal valid_subject.post, post
    end
  end
end
