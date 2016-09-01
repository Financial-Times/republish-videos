

require 'net/http'

environment_tag = ARGV[0]
if environment_tag == nil then
  puts "Usage: republish-videos.rb <environment_tag>\ne.g. republish-videos pub-pre-prod"
  Kernel.exit(1)
end

# content_endpoint = 'https://pub-pre-prod-up.ft.com/notification/brightcove/content'
# metadata_endpoint = 'https://pub-pre-prod-up.ft.com/notification/brightcove/metadata'

force_content_endpoint = "https://#{environment_tag}-up.ft.com/__brightcove-notifier/force-notify"
force_metadata_endpoint = "https://#{environment_tag}-up.ft.com/__brightcove-metadata-preprocessor/force-notify"


force_content_uri = URI("#{force_content_endpoint}/#{id}")
print force_content_uri.to_s