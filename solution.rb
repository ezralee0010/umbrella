require "http"
require "json"

# https://maps.googleapis.com/maps/api/geocode/json?address=Chicago&key=AIzaSyDKz4Y3bvrTsWpPRNn9ab55OkmcwZxLOHI 
# https://api.pirateweather.net/forecast/3RrQrvLmiUayQ84JSxL8D2aXw99yRKlx1N4qFDUE/41.8781136,-87.6297982

pp "Where are you?"

current_location = gets

pp current_location

gmaps_key = "AIzaSyDKz4Y3bvrTsWpPRNn9ab55OkmcwZxLOHI"

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{current_location}&key=#{gmaps_key}"

raw_gmaps_url = HTTP.get(gmaps_url)

parsed_gmaps = JSON.parse(raw_gmaps_url)

main_results = parsed_gmaps.fetch("results")

component = main_results.at(0)

outer_location = component.fetch("geometry")

inter_location = outer_location.fetch("location")

latitude = inter_location.fetch("lat")

longitude = inter_location.fetch("lng")

pp "your lat is #{latitude} and long is #{longitude}"

# Pirate

pirate_key = "3RrQrvLmiUayQ84JSxL8D2aXw99yRKlx1N4qFDUE"

pirate_url = "https://api.pirateweather.net/forecast/#{pirate_key}/#{latitude},#{longitude}"


weather_data = HTTP.get(pirate_url)

parsed_pirate = JSON.parse(weather_data)

outer_temp = parsed_pirate.fetch("currently")

inner_temp = outer_temp.fetch("temperature")

pp "Your temp is #{inner_temp}"

current_weather = outer_temp.fetch("precipType")

pp "Your current weather is #{current_weather}"
