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
port <%= @port %>
pidfile /var/run/redis_<%= @port %>.pid
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
<% unless @maxmemory == "" %>
maxmemory <%= @maxmemory %>
<% end %>
```

