### redis

```json
### json
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

```rb
### recipe

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

```erb
### template

port <%= @port %>
pidfile /var/run/redis_<%= @port %>.pid

<% unless @maxmemory == "" %>
maxmemory <%= @maxmemory %>
<% end %>
```

