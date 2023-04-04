# frozen_string_literal: true

require 'rouge/plugins/redcarpet'
require 'redcarpet'
require 'redcarpet/render_strip'

class CustomRenderHTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet

  # Rouge::Plugins::Redcarpetのメソッドを上書きする
  def block_code(code, language)
    # もしコードブロックに言語とファイル名が定義されたら取得する。例： ```ruby:test.rb
    filename = ''
    if language.present?
      filename = language.split(':')[1]
      language = language.split(':')[0]
    end

    lexer = Rouge::Lexer.find_fancy(language, code) || Rouge::Lexers::PlainText
    code.gsub!(/^    /, "\t") if lexer.tag == 'make'
    formatter = rouge_formatter(lexer)
    result = formatter.format(lexer.lex(code))
    return "<div class=#{wrap_class}>#{copy_button}#{result}</div" if filename.blank? && language.blank?

    compose_filename_and_language(result, filename, language)
  end

  def rouge_formatter(_options = {})
    options = {
      css_class: 'highlight',
      line_numbers: true,
      line_format: '<span>%i</span>'
    }
    Rouge::Formatters::HTMLLegacy.new(options)
  end

  private

  # wrap CSSクラス名の定義
  def wrap_class
    'highlight-wrap'
  end

  # コピーボタンの定義。クリックするとJavaScriptファンクションが実行される
  def copy_button
    "<button onclick='copy(this)'>Copy</button>"
  end

  # コードブロックの言語、ファイル名、コピーボタンを設置する
  def compose_filename_and_language(result, filename, language)
    info_section = [filename, language].select(&:present?).map.with_index do |text, i|
      i.zero? ? "<span class='highlight-info'>#{text}</span>" : nil
    end.compact.join

    %(<div class=#{wrap_class}>
        #{copy_button}
        #{info_section}
        #{result}
      </div>
    )
  end
end

module MarkdownHelper
  def plaintext(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
    markdown.render(text)
  end
  def markdown(text)
    options = {
      with_toc_data: true,
      hard_wrap: true
    }
    extensions = {
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      lax_spacing: true,
      lax_html_blocks: true,
      footnotes: true,
      space_after_headers: true,
      strikethrough: true,
      underline: true,
      highlight: true,
      quote: true
    }

    renderer = CustomRenderHTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end

  def toc(text)
    renderer = Redcarpet::Render::HTML_TOC.new(nesting_level: 6)
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(text).html_safe
  end
end
