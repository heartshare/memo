## 設定の変更方法

**Parameter Group** をあたらしく作成して設定変更を反映する

1. DB Parameter Groups
新しいグループつくる

2. パラメータ設定変更する

3. 対象のRDSの`Parameter Groups`を新しくつくって設定変えた`Parameter Groups`に変更

`Parameter Groups`を既存のRDSに追加する時は  
RDSの **再起動** が必要なので、可能であればRDS構築前に`Parameter Groups`を作成し  
RDS作成時に作成した`Parameter Groups`を選択できるようにしておく
