json.movies @movies do |movie|
  json.title movie.title
  json.plot movie.plot
end
json.seasons @seasons do |season|
  json.title season.title
  json.plot season.plot
  json.number season.number
end