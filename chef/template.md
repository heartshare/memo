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



