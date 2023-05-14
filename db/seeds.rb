#Cleaning up
Comment.destroy_all
Tagging.destroy_all
Tag.destroy_all
Post.destroy_all
User.destroy_all

password  = "12345678910"

user   = User.create!(username: "Richard", role: :user, email: "richard@email.com", password: password, password_confirmation: password)
writer = User.create!(username: "Joe", role: :writer, email: "joe@email.com", password: password, password_confirmation: password)
editor = User.create!(username: "Peter", role: :editor, email: "peter@email.com", password: password, password_confirmation: password)
admin  = User.create!(username: "Emily", role: :admin, email: "emily@email.com", password: password, password_confirmation: password)

post_authors = [writer, editor, admin]
comment_authors = [user, writer, editor, admin]

tag_news        = Tag.create(name: 'News')
tag_improvement = Tag.create(name: 'Improvement')
tag_training    = Tag.create(name: 'Training')
tag_photography = Tag.create(name: 'Photography')
tag_esports     = Tag.create(name: 'e-sports')
tag_math        = Tag.create(name: 'Math')
tag_physics     = Tag.create(name: 'Physics')
tag_programming = Tag.create(name: 'Programming')
tag_nature      = Tag.create(name: 'Nature')

comment_texts = ['That sounds interesting! Thanks for sharing!', 'I like that, I would be happy to read more about this!', 'It is an interesting approach!', 'Have you always been interested in this topic?', 'I can\'t understand the last part, can you please rephrase?']

generate_comments = Proc.new do
  Array.new(rand(1..4)) do
    {
      author_id: comment_authors.sample.id,
      body: comment_texts.sample
    }
  end
end

Post.create!([{
  title: "New material facilitates search for room-temperature superconductivity",
  author: post_authors.sample,
  body: "Scientists from Jilin University, the Center for High Pressure Science and Technology Advanced Research, and Skoltech have synthesized lanthanum-cerium polyhydride, a material that promises to facilitate studies of near-room-temperature superconductivity. It offers a compromise between the polyhydrides of lanthanum and cerium in terms of how much cooling and pressure it requires. This enables easier experiments, which might one day lead scientists to compounds that conduct electricity with zero resistance at ambient conditions—an engineering dream many years in the making. The study was published in Nature Communications.",
  tags: [tag_physics, tag_news],
  comments_attributes: generate_comments.call
},{
  title: "MORNING, NOON, OR NIGHT – IS THERE A PERFECT TIME TO RUN?",
  author: post_authors.sample,
  body: "Here are the main takeaways: If you want to maintain your performance level, you can train at any time of the day. Make sure you warm up properly. Midday runs are best for intense interval training to boost your performance. Training runs for general rest and recovery are best done in the evenings.",
  tags: [tag_training],
  comments_attributes: generate_comments.call
},{
  title: "Sony FE 50mm F1.4 GM Review",
  author: post_authors.sample,
  body: "The Sony FE 50mm F1.4 GM (SEL50F14GM) is a very fast standard prime lens for Sony Alpha full-frame mirrorless cameras. It can also be used on APS-C sensor Sony E-mount mirrorless cameras, where it provides a 75mm equivalent focal length. This is the second 50mm F1.4 Alpha-system lens that Sony have released, the first being the 7-year-old Sony Planar T* FE 50mm F1.4 ZA.",
  tags: [tag_photography, tag_news],
  comments_attributes: generate_comments.call
},{
  title: "THE ROAD TO CHAMPIONS 2023!",
  author: post_authors.sample,
  body: "Across the world, the competition in VALORANT Esports is heating up! All three international leagues are in full swing, top teams from each league will head to Masters Tokyo in June, Challenger Leagues Playoffs are on the horizon, and soon after we’ll find out which teams will earn promotion for the 2023 season. With so much competition taking place this summer, we wanted to create a roadmap for all the action taking place this summer as we get ready for Champions 2023!",
  tags: [tag_esports, tag_news, tag_improvement],
  comments_attributes: generate_comments.call
},{
  title: "Debunking the Dunning–Kruger effect",
  author: post_authors.sample,
  body: "In the 1990s, David Dunning and Justin Kruger were professors of psychology at Cornell University and wanted to test whether incompetent people were unaware of their incompetence.",
  tags: [tag_news, tag_math],
  comments_attributes: generate_comments.call
},{
  title: "Researchers discover superconductive images are actually 3D and disorder-driven fractals",
  author: post_authors.sample,
  body: "Meeting the world's energy demands is reaching a critical point. Powering the technological age has caused issues globally. It is increasingly important to create superconductors that can operate at ambient pressure and temperature. This would go a long way toward solving the energy crisis. Advancements with superconductivity hinge on advances in quantum materials. When electrons inside of quantum materials undergo a phase transition, the electrons can form intricate patterns, such as fractals. A fractal is a never-ending pattern. When zooming in on a fractal, the image looks the same. Commonly seen fractals can be a tree or frost on a windowpane in winter. Fractals can form in two dimensions, like the frost on a window, or in three-dimensional space like the limbs of a tree.",
  tags: [tag_news, tag_physics],
  comments_attributes: generate_comments.call
},{
  title: "Stack Overflow Will Charge AI Giants for Training Data",
  author: post_authors.sample,
  body: "Stack Overflow’s decision to seek compensation from companies tapping its data, part of a broader generative AI strategy, has not been previously reported. It follows an announcement by Reddit this week that it will begin charging some AI developers to access its own content starting in June.",
  tags: [tag_news, tag_programming],
  comments_attributes: generate_comments.call
},{
  title: "Hammerhead sharks are first fish found to ‘hold their breath’",
  author: post_authors.sample,
  body: "It pays to be an warm hunter in the cold ocean depths, so the animals shut down oxygen intake to conserve heat.",
  tags: [tag_nature],
  comments_attributes: generate_comments.call
},{
  title: "SOLID principles",
  author: post_authors.sample,
  body: "SOLID is an acronym that stands for five key design principles: single responsibility principle, open-closed principle, Liskov substitution principle, interface segregation principle, and dependency inversion principle. All five are commonly used by software engineers and provide some important benefits for developers",
  tags: [tag_programming, tag_improvement],
  comments_attributes: generate_comments.call
},{
  title: "Clean Code",
  author: post_authors.sample,
  body: "Even bad code can function. But if code isn’t clean, it can bring a development organization to its knees. Every year, countless hours and significant resources are lost because of poorly written code. But it doesn’t have to be that way.",
  tags: [tag_programming, tag_improvement],
  comments_attributes: generate_comments.call
},{
  title: "Ruby modules: Include vs Prepend vs Extend",
  author: post_authors.sample,
  body: "include is the most used and the simplest way of importing module code. When calling it in a class definition, Ruby will insert the module into the ancestors chain of the class, just after its superclass. On the other end, using extend on a class will actually import the module methods as class methods. Prepend: It actually works like include, except that instead of inserting the module between the class and its superclass in the chain, it will insert it at the bottom of the chain, even before the class itself.",
  tags: [tag_programming, tag_improvement],
  comments_attributes: generate_comments.call
},{
  title: "Dependency injection",
  author: post_authors.sample,
  body: "Dependency injection gives our code a higher loose coupling and by this more flexibility for changes as well as more testable code.",
  tags: [tag_programming, tag_improvement],
  comments_attributes: generate_comments.call
}])

puts 'Seeding complete'
puts 'Experience the application with the following credentials:'
puts '-'*75
puts 'Email'.ljust(30) + 'Password'.ljust(30) + 'Role'
puts user.email.ljust(30) + password.ljust(30) + user.role 
puts writer.email.ljust(30) + password.ljust(30) + writer.role 
puts editor.email.ljust(30) + password.ljust(30) + editor.role 
puts admin.email.ljust(30) + password.ljust(30) + admin.role 
