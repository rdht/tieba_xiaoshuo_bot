require './lib/fetch_fiction'
Dir.glob './**/worker/*.rb' do |f|
  require f
end
