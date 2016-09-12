

require 'net/http'

def republish_video(thread_id, video_count, video_id)
  tid = "republish-video-3-#{video_id}"
  @endpoints.each do |endpoint|
    uri = URI("#{endpoint}/#{video_id}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = @authorization
    request['X-Request-Id'] = tid
    response = http.request(request)
    print "date='%s' thread=%s n=%s tid=%s path='%s' resp=%d\n" % [Time.now(), thread_id, video_count, tid, uri.path, response.code]
    # sleep(0.50)
  end
end

environment_tag = ARGV[0]
if environment_tag == nil then
  puts "Usage: republish-videos.rb <environment_tag> <identifiers_filename> <authorization header> <parallelism>\ne.g. republish-videos pub-prod-uk identifiers.txt 'Basic abc...' 16"
  Kernel.exit(1)
end

identifiers_filename = ARGV[1]
if identifiers_filename == nil then
  puts "Usage: republish-videos.rb <environment_tag> <identifiers_filename> <authorization header> <parallelism>\ne.g. republish-videos pub-prod-uk identifiers.txt 'Basic abc...' 16"
  Kernel.exit(1)
end

@authorization = ARGV[2]
if @authorization == nil then
  puts "Usage: republish-videos.rb <environment_tag> <identifiers_filename> <authorization header> <parallelism>\ne.g. republish-videos pub-prod-uk identifiers.txt 'Basic abc...' 16"
  Kernel.exit(1)
end

@t = ARGV[3].to_i
if @t == nil then
  @t = 1
end

@endpoints = [
  # "http://localhost:8080/force-notify"
  "https://#{environment_tag}-up.ft.com/__brightcove-notifier/force-notify",
  "https://#{environment_tag}-up.ft.com/__brightcove-metadata-preprocessor/force-notify"
]

ids_for_threads = Array.new
for i in 0..@t-1 do
  ids_for_threads[i] = Queue.new
end

i = 0
File.open(identifiers_filename).each do |line|
  ids_for_threads[i] << line[0..-2]
  i = (i + 1) % @t
end

threads = Array.new
for i in 0..@t-1 do
  threads << Thread.new(i) { |i|
    sleep(rand)
    j = 0
    until ids_for_threads[i].empty? do
      id = ids_for_threads[i].pop
      republish_video(i, j, id)
      j += 1
    end
  }
end

threads.each do |thread|
  thread.join
end

puts "The end."
