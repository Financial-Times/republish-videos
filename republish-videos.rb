

require 'net/http'

environment_tag = ARGV[0]
if environment_tag == nil then
  puts "Usage: republish-videos.rb <environment_tag> <identifiers_filename>\ne.g. republish-videos pub-prod-uk identifiers.txt 'Basic abc...'"
  Kernel.exit(1)
end

identifiers_filename = ARGV[1]
if identifiers_filename == nil then
  puts "Usage: republish-videos.rb <environment_tag> <identifiers_filename>\ne.g. republish-videos pub-prod-uk identifiers.txt 'Basic abc...'"
  Kernel.exit(1)
end

authorization = ARGV[2]
if authorization == nil then
  puts "Usage: republish-videos.rb <environment_tag> <identifiers_filename> <authorization header>\ne.g. republish-videos pub-prod-uk identifiers.txt 'Basic abc...'"
  Kernel.exit(1)
end

# content_endpoint = 'https://pub-pre-prod-up.ft.com/notification/brightcove/content'
# metadata_endpoint = 'https://pub-pre-prod-up.ft.com/notification/brightcove/metadata'

force_content_endpoint = "https://#{environment_tag}-up.ft.com/__brightcove-notifier/force-notify"
force_metadata_endpoint = "https://#{environment_tag}-up.ft.com/__brightcove-metadata-preprocessor/force-notify"

i = 1
File.open(identifiers_filename).each do |line|
  id = line[1..-3]
  tid = "republish-video-#{i}-#{id}"
  
  force_content_uri = URI("#{force_content_endpoint}/#{id}")
  print "%s. - %s - %s" % [i, tid, force_content_uri.path]
  http = Net::HTTP.new(force_content_uri.host, force_content_uri.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(force_content_uri)
  request['Authorization'] = authorization
  request['X-Request-Id'] = tid
  response = http.request(request)
  print " - %d" % [response.code]
  
  force_metadata_uri = URI("#{force_metadata_endpoint}/#{id}")
  print " - %s" % [force_metadata_uri.path]
  http = Net::HTTP.new(force_metadata_uri.host, force_metadata_uri.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(force_metadata_uri)
  request['Authorization'] = authorization
  request['X-Request-Id'] = tid
  response = http.request(request)
  print " - %d" % [response.code]
  # response.is_a?(Net::HTTPSuccess)
  # list_posts_result = Net::HTTP.get_response(list_posts_uri)
  print "\n"
  i += 1
  sleep(0.10)
end
