# encoding: utf-8

if Section.count == 0
  Section.create!([
    {id: 1, display_name: "News", tag_color: "#ff6c0c"},
    {id: 2, display_name: "Campus", tag_color: "#ff6c0c"},
    {id: 3, display_name: "City, Nation & World", tag_color: "#ff6c0c"},
    {id: 4, display_name: "Opinion", tag_color: "#ff6c0c"},
    {id: 5, display_name: "Culture", tag_color: "#ff6c0c"},
    {id: 6, display_name: "Announcements", tag_color: "#ff6c0c"},
    {id: 7, display_name: "Sports", tag_color: "#ff6c0c"}
  ])
end

if FeatureSlot.count == 0
  FeatureSlot.create!([
    { position: :main },
    { position: :side_news, priority: 1 },
    { position: :side_news, priority: 2 },
    { position: :side_news, priority: 3 },
    { position: :side_news, priority: 4 },
    { position: :side_news, priority: 5 },
    { position: :opinion, priority: 1 },
    { position: :opinion, priority: 2 },
    { position: :opinion, priority: 3 },
    { position: :opinion, priority: 4 },
    { position: :opinion, priority: 5 },
    { position: :faculty_profile, priority: 1 },
    { position: :culture_feature, priority: 1 }
  ])
end

if Rails.env == 'development'
  # generate authors=
  if Author.count == 0
    5.times do |n|
      Author.create(name: Faker::Name.unique.name, email: Faker::Internet.email, description: Faker::Lorem.sentence)
    end

    10.times do |n|
      Article.create(title: Faker::Lorem.sentence, sub_title: Faker::Lorem.sentence, content: Faker::Lorem.paragraphs(number: 3).join('\n\n'),
                     published: true, published_at: DateTime.parse("2020-08-26"), section_id: Section.all.sample.id, author_ids: [Author.all.sample.id])
    end
  end
end