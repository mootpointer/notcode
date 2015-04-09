#encoding: UTF-8

xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/",  :version => "2.0" do
  xml.channel do
    xml.title "Not Code."
    xml.author "Andrew Harvey"
    xml.description "A podcast for tech people about everything but code."
    xml.link "http://notco.de"
    xml.language "en"
    xml.itunes :author, "Andrew Harvey"
    xml.itunes :explicit, 'clean'
    xml.itunes :owner do
      xml.itunes :name, "Not Code."
      xml.itunes :email, 'andrew@mootpointer.com'
    end

    for episode in episodes
      xml.item do
        if episode.title
          xml.title episode.title
        else
          xml.title ""
        end
        xml.author episode.data.guests

        xml.pubDate episode.date.to_s(:rfc822)
        xml.link "http://notco.de/" + episode.url
        xml.guid episode.url
        xml.pubdate episode.date.rfc2822
        xml.enclosure url: episode.data.media_url, length: episode.data.file_size, type: "audio/mpeg"
        xml.itunes :subtitle, truncate(episode.summary, :length => 150)
        xml.itunes :duration, episode.data.duration
        xml.itunes :author, episode.data.guests
        xml.itunes :summary do
          xml.cdata! episode.summary
        end
        xml.itunes :explicit, "no"

      end
    end
  end
end

