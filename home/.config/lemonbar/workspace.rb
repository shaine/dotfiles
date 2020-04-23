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

  workspace_nodes = flatten_nodes_tree(workspace["nodes"])
  workspace_nodes += flatten_nodes_tree(workspace["floating_nodes"])
  apps = workspace_nodes.select { |n| !n["name"].nil? }
  apps.count > 0
end

i3_tree = `i3-msg -t get_tree`
i3_tree_hash = JSON.parse(i3_tree)

i3_workspaces = `i3-msg -t get_workspaces`
i3_workspaces_hash = JSON.parse(i3_workspaces)

active_color = "$BFG"
inactive_color = "$BBG"
empty_symbol = "•"
full_inactive_symbol = ""
full_active_symbol = ""
warning_symbol = ""

output_prefix = "%{F#{inactive_color} B#{inactive_color}} "
workspaces_output = []

i3_workspaces_hash.each do |workspace|
  # Num is 1-indexed
  workspace_index = workspace["num"] - 1

  is_focused = workspace["focused"]
  is_urgent = workspace.fetch("urgent")

  symbol = workspace_has_windows?(i3_tree_hash, workspace_index) ? full_inactive_symbol : empty_symbol
  symbol = is_focused && workspace_has_windows?(i3_tree_hash, workspace_index) ? full_active_symbol : symbol
  symbol = is_urgent ? warning_symbol : symbol

  output =
    if workspace && is_focused
      "%{F#{inactive_color} B#{active_color}} #{symbol} %{F#{active_color} B#{inactive_color}}"
    else
      "%{F#{active_color} B#{inactive_color}} #{symbol} "
    end

  workspaces_output[workspace_index] = output
end

workspaces_output = workspaces_output.map do |workspace_output|
  next workspace_output unless workspace_output.nil?

  "%{F#{active_color} B#{inactive_color}} #{empty_symbol} "
end

puts "#{output_prefix}#{workspaces_output.join}"
