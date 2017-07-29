#!/usr/bin/env ruby

require 'open-uri'
require 'json'

# Sample response from HN API when querying an ID
# {"by"=>"janober",
# "descendants"=>71,
# "id"=>14866118,
# "kids"=>[14866272, 14867334, 14867204, 14866556, 14866372, 14867635, 14866841, 14866398, 14866599, 14866251],
# "score"=>51,
# "time"=>1501168927,
# "title"=>"Apple Apparently Discontinues iPod Nano and iPod Shuffle",
# "type"=>"story",
# "url"=>"https://www.macrumors.com/2017/07/27/apple-removes-ipod-nano-ipod-shuffle/"}


class HNReader
  attr_reader :top_ids

  URI_STRING = "https://hacker-news.firebaseio.com/v0"

  def initialize
    gettop
  end

  def gettop
    uri = URI(URI_STRING)
    uri.path  += '/topstories.json'
    uri.query = 'print=pretty'
    res = uri.open
    # We get back a string that looks like an array. HACK to extract the items. They're still strings
    @top_ids = res.read.delete(']').delete('[').delete(',').split(' ')
  end

  def request(id)
    uri = URI(URI_STRING)
    uri.path += "/item/#{id}.json"
    res = uri.open
    JSON.parse res.read
  end
end
