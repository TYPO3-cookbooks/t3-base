motd "50-chef" do
  source "motd.erb"
  cookbook cookbook_name
  variables({
    run_list: (if node['run_list'] then node['run_list'] else ["empty"] end)
            })
end