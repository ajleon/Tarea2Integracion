class ApiController < ApplicationController
  def buscar

    tag_search = JSON.parse(HTTP.headers(:"Content-Type" => "application/json").get("https://api.instagram.com/v1/tags/search?q="+tag+"&access_token="+access_token).to_s, :symbolize_names => true)



    media = JSON.parse(HTTP.headers(:"Content-Type" => "application/json").get("https://api.instagram.com/v1/tags/"+tag+"/media/recent?access_token="+access_token).to_s, :symbolize_names => true)

    posts = []

    media[0][:data].each do |media_found|


      tags = []

      media_found[:tags].each do |tag|

        tags.push(tag)

      end

      if media_found[:type] == "video"
        url = media_found[:videos][:standard_resolution]
      else
        url = media_found[:images][:standard_resolution]
      end
      post = {:tag => tags,:username=> media_found[:user], :likes=> media_found[:likes][:count], :url => url, :caption => media_found[:caption][:text]}

      posts.push(tag_founnd)
    end

    count =0
    tag_search[0][:data].each do |tag_count|


      count += tag_count[:media_count]
    end



    response = { :metadata => { :total => count}, :posts => post}
    render :json => response
  end
end
