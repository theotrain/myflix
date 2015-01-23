Fabricator(:queue_item) do 
  video {Fabricate(:video)}
  display_order {[1,2,3].sample}
end