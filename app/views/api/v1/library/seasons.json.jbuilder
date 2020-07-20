json.seasons @seasons do |season|
  json.title season.title
  json.plot season.plot
  json.number season.number
  # episodes are usually out once per week so we can expire cache in 1 week
  json.cache! ['v1', season], expires_in: 1.week do
    json.episodes season.episodes do |episode|
      json.title episode.title
      json.plot episode.plot
      json.number episode.number
    end
  end
end