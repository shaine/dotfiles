#!/usr/bin/env ruby

require "json"

desktop_count = ENV.fetch("DESKTOP_COUNT", 5)
i3_workspaces = `i3-msg -t get_workspaces`
output = "%{F${color_back} B${color_sec_b1} T1} "

i3_workspaces_hash = JSON.parse(i3_workspaces)

desktop_count.times do |desktop_number|
  workspace = i3_workspaces_hash.find { |temp_ws| temp_ws["num"] == desktop_number + 1 }

  if workspace && workspace["focused"]
    output += "%{F${color_sec_b1} B${color_head} T3}${sep_right}%{F${color_back} B${color_head} T1}  %{F${color_head} B${color_sec_b1} T3}${sep_right}"
  else
    output += "%{F- T1} • "
  end
end

puts output
