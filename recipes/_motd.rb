motd "50-chef" do
  source "motd.erb"
  cookbook cookbook_name
  variables({
    run_list: JSON.parse(node.run_list.to_json)
            })
end