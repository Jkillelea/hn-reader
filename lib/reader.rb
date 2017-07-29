#!/usr/bin/env ruby

require 'open-uri'
require 'json'

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
    @top_ids = res.read.delete(']').delete('[').delete(',').split(' ')
  end

  def request(id)
    uri = URI(URI_STRING)
    uri.path += "/item/#{id}.json"
    res = uri.open
    JSON.parse res.read
  end
end
