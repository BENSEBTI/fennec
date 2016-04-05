json.array!(@plates) do |plate|
  json.extract! plate, :id, :siteid, :camid, :plate, :confidence, :process, :x, :y, :uuid
  json.url plate_url(plate, format: :json)
end
