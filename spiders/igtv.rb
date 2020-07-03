class Igtv < ApplicationSpider
  BASE_URL = 'https://www.instagram.com'
  @name = "igtv"
  @start_urls = [BASE_URL]
  @engine = 'selenium_chrome'

  def parse(response, url:, data: {})
    browser.fill_in "username", with: ENV['INSTAGRAM_USERNAME']
    browser.fill_in "password", with: ENV['INSTAGRAM_PASSWORD']

    browser.click_button "Log In"

    if browser.has_xpath?("//button[text()='Not Now']")
      browser.click_button "Not Now"
    end

    request_to :parse_channel, url: "#{BASE_URL}/#{ENV['INSTAGRAM_TARGET_USERNAME']}/channel/"
  end

  def parse_channel(response, url:, data: {})
    sleep 4

    paths = []
    ENV.fetch('PAGES', '5').to_i.times do
      # scroll to appear more videos
      browser.execute_script("window.scrollBy(0,10000)")
      sleep 2
      current_paths = browser
                        .current_response
                        .css('a')
                        .select { |tag_a| tag_a[:href].start_with?('/tv') }
                        .map { |tag_a| tag_a[:href] }
      paths = paths + current_paths
    end

    urls = paths.uniq.map { |path| "#{BASE_URL}#{path}" }

    in_parallel(:parse_video_page, urls, threads: ENV.fetch('THREADS', '4').to_i)
  end

  def parse_video_page(response, url:, data: {})
    videos = response.xpath('//video')
    video_url = videos.first[:src]

    if unique?(:video, video_url)
      text_container = response.xpath('//li[@role="menuitem"]//h2/following-sibling::span')

      text_html = text_container.to_html.split('<br><br>')
      title_html = text_html.first
      description_html = text_html.last
      title = Nokogiri::HTML::DocumentFragment.parse(title_html).text
      description = Nokogiri::HTML::DocumentFragment.parse(description_html).text

      logger.info(title)

      item = {
        title: title,
        post_url: browser.current_url,
        description: description,
        video_url: video_url
      }
      save_to "results.json", item, format: :pretty_json, position: false
    end
  end
end
