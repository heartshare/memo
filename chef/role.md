### Role 

> Chef 11.4

roleに共通の項目を記載して  
各ホストはroleのjsonを見に行くようにする

`/root/chef/json/hoge-web.json`  

```json
{
  "name": "hoge-web",
  "default_attributes": {
    "nginx": { "version" : "1.2.3" }
  },
  "override_attributes": { },
  "json_class": "Chef::Role",
  "description": "",
  "chef_type": "role",
  "run_list": [
    "recipe[nginx]", "recipe[fluent-agent-lite]"
  ]
}
```

`/root/chef/json/hoge-web01.json`  

```json
{
  "run_list": [
    "role[hoge-web]"
  ]
}
```

`/root/chef/json/hoge-web02.json`  

```json
{
  "run_list": [
    "role[hoge-web]"
  ]
}
```
