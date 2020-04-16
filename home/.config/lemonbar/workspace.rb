#!/usr/bin/env ruby

require "json"

def flatten_nodes_tree(arr, all=[])
  arr.each do |item|
    next unless item.class == Hash

    all << item

    flatten_nodes_tree(item["nodes"], all) if item["nodes"]&.size > 0
  end

  all
end

def workspace_has_windows?(i3_tree_hash, workspace_num)
  real_nodes = i3_tree_hash["nodes"].select { |n| n["name"] != "__i3" }
  workspaces = flatten_nodes_tree(real_nodes).select { |n| n["type"] == "workspace" }
  workspace = workspaces.find { |n| n["num"] == workspace_num + 1 }
  return false if workspace.nil?

  apps = flatten_nodes_tree(workspace["nodes"]).select { |n| !n["name"].nil? }
  apps.count > 0
end

desktop_count = ENV.fetch("DESKTOP_COUNT", 5)
i3_tree = `i3-msg -t get_tree`
i3_tree_hash = JSON.parse(i3_tree)

i3_workspaces = `i3-msg -t get_workspaces`
i3_workspaces_hash = JSON.parse(i3_workspaces)

active_color = "${color_head}"
inactive_color = "${color_sec_b1}"
urgent_active_color = "${bg_warn}"
urgent_inactive_color = "${bg_warn}"
right_arrow = "${sep_right}"

output = "%{F#{inactive_color} B#{inactive_color} T1} "

desktop_count.times do |desktop_number|
  workspace = i3_workspaces_hash.find { |temp_ws| temp_ws["num"] == desktop_number + 1 }

  is_focused = workspace && workspace["focused"]
  is_urgent = workspace&.fetch("urgent")

  symbol = workspace_has_windows?(i3_tree_hash, desktop_number) ? "" : "•"
  symbol = is_focused && workspace_has_windows?(i3_tree_hash, desktop_number) ? "" : symbol
  symbol = is_urgent ? "" : symbol

  current_active_color = is_urgent ? urgent_active_color : active_color
  current_inactive_color = inactive_color

  if workspace && is_focused
    output += "%{F#{current_inactive_color} B#{current_active_color} T3}#{right_arrow}%{F#{current_inactive_color} B#{current_active_color} T1} #{symbol} %{F#{current_active_color} B#{current_inactive_color} T3}#{right_arrow}"
  else
    output += "%{F#{current_active_color} B#{current_inactive_color} T1} #{symbol} "
  end
end

puts output
