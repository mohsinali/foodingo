curl -X GET -H "X-Parse-Application-Id: kDmDHoGKf4YGo8aCwJWqkOJbmOWtE3R2VUbeI7v0" -H "X-Parse-REST-API-Key: eqfkwzIh575lJWiTanlIEShH563QdiSV7cm5a6ZA" -G --data-urlencode 'where={"objectId":"mraJfMPNaH"}' https://api.parse.com/1/classes/cafedb

response = RestClient::Request.execute(method: :get, url: 'https://api.parse.com/1/classes/cafedb?where={"location": { "$nearSphere": { "__type": "GeoPoint", "latitude": 30.0, "longitude": -20.0 }, "$maxDistanceInKilometers": 10.0 } }', headers: {:"X-Parse-Application-Id" => "kDmDHoGKf4YGo8aCwJWqkOJbmOWtE3R2VUbeI7v0", :"X-Parse-REST-API-Key" => "eqfkwzIh575lJWiTanlIEShH563QdiSV7cm5a6ZA", :"Content-Type" => "application/json"})

response = RestClient::Request.execute(method: :get, url: 'https://api.parse.com/1/classes/cafedb?where={"location": { "$nearSphere": { "__type": "GeoPoint", "latitude": "1.334196", "longitude": "103.963013" }, "$maxDistanceInKilometers": "10.0" } }', headers: {:"X-Parse-Application-Id" => "kDmDHoGKf4YGo8aCwJWqkOJbmOWtE3R2VUbeI7v0", :"X-Parse-REST-API-Key" => "eqfkwzIh575lJWiTanlIEShH563QdiSV7cm5a6ZA", :"Content-Type" => "application/json"})