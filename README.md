# About

This is the Factual supported Ruby driver for [Factual's public API](http://developer.factual.com).


# Overview

## Basic Design

The driver allows you to create an authenticated handle to Factual. With a Factual handle, you can send queries and get results back.

Queries are created using the Factual handle, which provides a fluent interface to constructing your queries. 

````ruby
# You can chain the query methods, like this:
factual.table("places").filters("category" => "Food & Beverage > Restaurants").search("sushi", "sashimi")
  .geo("$circle" => {"$center" => [34.06021, -118.41828], "$meters" => 5000})
  .sort("name").page(2, :per => 10)
````

Results are returned as Ruby Arrays of Hashes, where each Hash is a result record.

## Setup

The driver's gems are hosted at [Rubygems.org](http://rubygems.org). 

You can install the factual-api gem as follows:

````bash
$ gem install factual-api
````

Or add one line to the Gemfile of your Rails project, and run `bundle`:

````ruby
gem 'factual-api'
````

Once the gem is installed, you can use it in your Ruby project like:

````ruby
require 'factual'
factual = Factual.new("YOUR_KEY", "YOUR_SECRET")
````
If you don't have a Factual API account yet, [it's free and easy to get one](https://www.factual.com/api-keys/request).
  
## Simple Read Examples

`````ruby
# Return entities from the Places dataset with names beginning with "starbucks"
factual.table("places").filters("name" => {"$bw" => "starbucks"}).rows
````

`````ruby
# Return entity names and non-blank websites from the Global dataset, for entities located in Thailand
factual.table("places").select(:name, :website)
  .filters({"country" => "TH", "website" => {"$blank" => false}})
````

`````ruby
# Return highly rated U.S. restaurants in Los Angeles with WiFi
factual.table("restaurants")
  .filters({"locality" => "los angeles", "rating" => {"$gte" => 4}, "wifi" => true}).rows
````

## Simple Places Example

````ruby
# Returns resolved entities as an array of hashes
query = factual.resolve("name" => "McDonalds",
                        "address" => "10451 Santa Monica Blvd",
                        "region" => "CA",
                        "postcode" => "90025")

query.first["resolved"]   # true or false
query.rows                # all candidate rows
````

````ruby
# Returns the nearest valid address information
query = factual.geocode(34.06021,-118.41828)
query.first
````

````ruby
# Returns georeferenced attributes generated by Factual
query = factual.geopulse(34.06021,-118.41828).select("area_statistics", "income", "housing")
query.first["income"]
````

## More Read Examples

````ruby
# 1. Specify the table Global Places
query = factual.table("places")
````

````ruby
# 2. Filter results in country US
query = query.filters("country" => "US")
````

````ruby
# 3. Search for "sushi" or "sashimi"
query = query.search("sushi", "sashimi")
````

````ruby
# 4. Filter by geolocation
query = query.geo("$circle" => {"$center" => [34.06021, -118.41828], "$meters" => 5000})
````

````ruby
# 5. Sort it 
query = query.sort("name")            # ascending 
query = query.sort_desc("name")       # descending
query = query.sort("address", "name") # sort by multiple columns
````

````ruby
# 6. Page it
query = query.page(2, :per => 10)
````

````ruby
# 7. Finally, get response in a hash or array of hashes
query.first    # return one row
query.rows     # return many rows
````

````ruby
# 8. Returns total row counts that matches the criteria
query.total_count
````

# Where to Get Help

https://github.com/Factual/factual-ruby-driver/wiki/Debug-and-Support

If you think you've identified a specific bug in this driver, please file an issue in the github repo. Please be as specific as you can, including:

  * What you did to surface the bug
  * What you expected to happen
  * What actually happened
  * Detailed stack trace and/or line numbers

If you are having any other kind of issue, such as unexpected data or strange behaviour from Factual's API (or you're just not sure WHAT'S going on), please contact us through [GetSatisfaction](http://support.factual.com/factual).

# Ruby Driver Wiki
https://github.com/Factual/factual-ruby-driver/wiki
