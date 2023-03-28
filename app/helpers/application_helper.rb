module ApplicationHelper
  def default_meta_tags
    {
      site: "If you want to go far, go together",
      title: "Together",
      reverse: true,
      charset: "utf-8",
      description: "一人ではなし得ないことも、みんなで協力すれば成し遂げられる! ともに学ぶ仲間がここにはたくさんいます。初めてみよう！",
      keywords: "勉強会,ウェブエンジニア,技術ブログ,Ruby,Ruby on Rails, HTML, CSS, javascript, SCSS",
      canonical: request.original_url,
      separator: "|",
      icon: [
        { href: image_url("default.jpg") },
        { href: image_url("default.jpg"), rel: "apple-touch-icon", sizes: "180x180", type: "image/jpg" },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_url("default.jpg"),
        local: "ja-JP",
      },
      twitter: {
        card: "summary_large_image",
        site: "@aaaairinkiyowo",
        image: image_url("default.jpg"),
      },
    }
  end
end
