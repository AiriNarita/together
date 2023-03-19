Faker::Config.locale = :ja
10.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    first_name_kana: Faker::Name.first_name,
    last_name_kana: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8),
  )
  15.times do
    title = Faker::Lorem.sentence(word_count: 3)
    body = Faker::Lorem.paragraph(sentence_count: 3)

    @post = Post.create(
      title: title,
      body: body,
      user_id: user.id,
      post_status: 0,
    )

    tags = []
    3.times do
      tags << "#" + Faker::Lorem.word
    end

    # 重複を削除する
    sent_tags = tags.join(" ").scan(/#\w+/).map(&:strip).uniq.map(&:downcase)

    # 既存のハッシュタグを取得する
    existing_tags = Hashtag.where(hashtag_name: sent_tags)

    existing_tags.each do |tag|
      post_hashtag = PostHashtag.where(hashtag_id: tag.id, post_id: @post.id)
      PostHashtag.create(hashtag_id: tag.id, post_id: @post.id)
    end

    # 既存のハッシュタグと重複していないタグを追加する
    new_tags = sent_tags - existing_tags.pluck(:hashtag_name)
    new_tags.each do |tag_name|
      tag = Hashtag.create(hashtag_name: tag_name)
      PostHashtag.create(hashtag_id: tag.id, post_id: @post.id)
    end
  end

  15.times do
    Event.create(
      event_name: Faker::Lorem.sentence(word_count: 3),
      event_introduction: Faker::Lorem.paragraph(sentence_count: 3),
      date: Faker::Time.between(from: 3.months.ago, to: DateTime.now + 3.months),
      url: Faker::Internet.url,
      creator_id: user.id,
    )
  end
end
