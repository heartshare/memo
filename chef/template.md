Template


```
### hoge/template/default/hoge.conf.erb

<% node[:hoo][:one].keys.sort.each do |oneone| %>
<% node[:hoo][:two].each do |twotwo| %>
<%= oneone %> hogehoge <%= twotwo %>
<% end %>
<% end %>


<% node[:aliases].keys.sort.each do |name| %>
<%= name.to_s %>:               <%= node[:aliases][name] %>
<% end %>


<% if node[:hoge].to_i == 5 %>
 hogehoge
<% else %>
 hogehoge
<% end %>
```


### redis

```json
{
    "redis": {
     "ports": [
       "6379", "6380"
     ],
     "maxmemory": {
       "6379": "4g",
       "6380": ""
     }
}
```

```recipe
  template "/etc/redis/#{port}.conf" do
    owner "root"
    mode  0755
    source "redis.conf.erb"

    variables(
      :port      => port,
      :maxmemory => node["redis"]["maxmemory"]["#{port}"]
    )
  end

end
```

```template
<% unless @maxmemory == "" %>
maxmemory <%= @maxmemory %>
<% end %>
```
