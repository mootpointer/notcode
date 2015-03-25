Dotenv.load
###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

helpers do
  def current_or_link text, path, opts={}
    if current_page? path
      content_tag :span, text, class: "current"
    else
      link_to text, path
    end
  end

  def current_page? path
    url_for(path) == url_for(current_page.url)
  end

end


# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

page '/podcast.rss', :layout => false, :directory_index => false

activate :sync do |sync|
  sync.fog_provider = "AWS"
  sync.fog_directory = "notco.de"
  sync.aws_access_key_id =  ENV['AWS_ACCESS_KEY_ID']
  sync.aws_secret_access_key =  ENV['AWS_SECRET_ACCESS_KEY']
  sync.after_build = true
  sync.gzip_compression = true
end

activate :blog do |blog|
  blog.prefix = "episodes"
  blog.permalink = "{year}/{title}.html"
  blog.layout = "episodes_layout"
  blog.summary_separator = /END_SUMMARY/
end

activate :directory_indexes
# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
