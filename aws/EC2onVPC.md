# EC2をVPCにアサインして外部から接続する  
  
VPCにアサインされたEC2インスタンスへ    
Network Interfaceを追加し、外部からVPC内のインスタンスへ接続できるようにする。    
  
画像がないのでわかりづらいけど自分用メモということで。  
  
  
#### Q&A  
  
- 1つの VPC に付き20のサブネットを作成できます  
- サブネットの最小サイズは /28 です（14 IP アドレス）  
- 各サブネットにおいて、Amazon が先頭の4 IP アドレスを確保し    
最後の1 IP アドレスは、IP ネットワーキングの目的で確保されます。  
  
#### AZはどこで決まるのか  
  
subnetを設定する時に決められる  
  
  
## 1. VPCを作成  
  
*VPC -> Your VPCs -> Create VPC*  
  
***CIDR Block:*** 作成するVPCで利用したいセグメントを指定    
VPCはVPC内で複数のサブネットワーク帯を持つことが可能。  
  
> exp)    
>  CIDR Block: 192.168.0.0/16    
>  Subnet one: 192.168.2.0/24    
>  Subnet two: 192.168.2.1/24    
>  ...    
  
VPC内でRDS動かす予定がある人は    
取り敢えず***/16***ぐらいで確保しておかないと    
RDSのDB Subnet Groups作成時にAZを少なくとも2つ指定しないといけなくて    
詰む可能性が高いです。  
  
***tenancyオプション***    
そのVPCに入るインスタンスは、同一の物理的サーバ(シングルテナント)を利用することができる。    
(デディケイティッド・インスタンス)    
費用：1インスタンス $10/hour + インスタンス費用+α    
  
VPCが作成されます。  
  
  
## 2. Subnetを作成    
  
*VPC -> Your VPCs -> Subnets -> Create Subnet*  
  
***VPC:*** さきほど作成したVPCを指定    
***Availability Zone:*** 使用したいAZを選択    
***CIDR Block:*** 使用したいサブネットを指定    
  
サブネットが作成されます。  
  
  
## 3. Internet Gatewaysを作成  
  
*VPC -> Your VPCs -> Internet Gateway -> Create Internet Gateway*  
  
Yes, Createを選択  
  
*VPC -> Your VPCs -> Internet Gateway -> Attach to VPC*  
  
***VPC:*** さきほど作成したVPCを指定  
  
Internet Gatewayが作成されます。  
  
  
## 4. Route Tableを作成  
  
*VPC -> Route Tables -> Create Route Table*  
  
***VPC:*** さきほど作成したVPCを指定  
  
作成されたRoute Tableをクリック    
  
*Route Table -> Routes*    
  
> Destination: 0.0.0.0/0    
>      Target: さきほど作成したInternet Gatewayを指定    
> Add  
  
外部との接続用のRoute Tableが作成されます。  
  
  
これで下地ができたので、EC2のインスタンスを作成します。  
  
  
## 5. EC2のインスタンスを作成  
  
*EC2 -> Instances -> Launch Instance*    
  
ウィザードでEC2とVPCを選択できる箇所があるので    
VPCを選択。VPCを選択した際にサブネットを選択できるので    
作成したサブネットを選択。  
  
  
### 6. Elastic IP用のNetwork Interfaceを作成  
  
*EC2 -> Network Interfaces -> Create Network Interface*    
  
> Description: わかりやすい名前を    
> Subnet: さきほど作成したサブネットを指定  
  
Yes, Create を選択しNetwork Interfaceを作成  
  
Network Interfaceが作成されます。  
  
  
### 7. 作成したNetwork InterfaceをEC2のインスタンスに追加    
  
*EC2 -> Instance -> 対象のインスタンスを選択し右クリック*    
  
***Attach Network Interface***を選択し    
さきほど作成したサブネットを選択    
  
Yes, Attachを選択し、Network Interfaceを追加  
  
Network Interfaceが追加されます。  
  
  
### 8. Elastic IPをVPCにアサイン  
  
*EC2 -> Elastic IPs -> Allocate New Address*    
  
***EIP used in:*** VPC を選択    
  
Yes, Allocateを選択    
  
Elastic IPがVPCにアサインされます。  
  
  
### 7. VPC内のインスタンスにEIPを付与    
  
*VPC -> Elastic IPs*    
  
6でVPCにアサインされたEIPを選択    
***Associate Address***を選択    
  
Network Interface: 先ほど追加したNetwork Interfaceを選択  
  
これで接続が可能になっています。    
あとはよしなにSecurity Groupを変更し    
疎通の確認を行います。  
  
  
### 8. VPCのセキュリティグループを許可  
  
  
 
