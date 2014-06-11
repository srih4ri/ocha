set :haml, :format => :html5

get '/' do
  if words = params[:words]
    name = djb2 words
    file_name = "#{name}.mp3"
    file_path = file_path file_name

    unless File.exists? file_path
      %x"echo '#{words}'| text2wave | lame - #{file_path}"
      puts "Cache Miss Writing to #{file_path}"
    else
      puts "Cache Hit #{file_path}"
    end

    redirect "/mp3s/#{file_name}"
  end
  haml :index
end

def djb2 str
  hash = 5381
  str.each_byte do |b|
    hash = (((hash << 5) + hash) + b) % (2 ** 32)
  end
  hash
end

def file_path fname
  @cached_file_name ||= "./public/mp3s/#{fname}"
end
