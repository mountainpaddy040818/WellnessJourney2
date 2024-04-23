# WellnessJourney
​
## サイト概要
### サイトテーマ
健康な体を築くために筋肉トレーニングをしている人々が<br>
効果的な筋トレ法や適切な食事など様々な情報を共有するための自己啓発的コミュニティサイト
​
### テーマを選んだ理由
近年、IT技術の進歩により続々と便利な製品がリリースされております。<br>
外出しなくとも仕事、食事や買い物などほぼ自宅で済ませることが可能な社会です。<br>
しかし、その便利さが故にある懸念が生まれてしまいます。<br>
それは運動不足です。<br>
運動不足は健康に生活していく上で多大なリスクを及ぼし、<br>
それにより引き起こされてしまう生活習慣病も数多く存在します。<br>
筋トレをしている方々が繋ることで日々のトレーニングの励みになり、<br>
一人でも多く健康な人々を増やすことができればと思いこのサイトを考案しました。
​
### ターゲットユーザ
- 最近運動不足で筋トレを始めたけど、やり方がいまいち分かっていない方
- 筋トレの日報を書くことで日々のモチベーションにしたいと考えている方<br>
などなど、どんな方でもご利用いただくことが出来ます！
​
### 主な利用シーン
- 筋トレの日報を投稿
- 食事内容の投稿
- 筋トレに関する豆知識の共有 etc.

<!--## [WellnessJourney](https://wellnessjourney.xyz)-->
​
## 設計書

### システム構成図<br>
![スクリーンショット 2024-04-14 16 46 26](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/23cff5d5-faee-4556-a668-584d7b4e2306)

### ER図<br>
![スクリーンショット 2024-03-29 13 21 17](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/1d6e390b-a55f-4e27-951b-e6bb49dd8ac4)

### テーブル定義書
<br><br>
#### users<br>
![スクリーンショット 2024-03-29 0 33 16](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/5f798c03-f864-4885-9448-84284094a48d)

#### health_records<br>
![スクリーンショット 2024-04-23 15 54 33](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/cc26b55c-6c5f-43fd-a7a3-1fd86c1de1ad)

#### health_record_comments<br>
![スクリーンショット 2024-03-28 23 53 38](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/c2000d91-70a9-4f6a-abf4-7dcfec2a1693)

#### groups<br>
![スクリーンショット 2024-04-23 14 24 45](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/24f4d130-6eb1-447a-b02f-ae9d9522de7c)

#### group_users<br>
![スクリーンショット 2024-03-28 23 54 59](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/2b509f49-1d9d-4f87-95dc-9a0ce697a3ad)

#### genres<br>
![スクリーンショット 2024-03-28 23 56 53](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/253c3029-72ce-422c-9783-9c8b7280fe06)

#### favorites<br>
![スクリーンショット 2024-03-28 23 57 01](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/55a06ff8-b55a-4f86-8f95-8228ce479a5f)

#### relationships<br>
​![スクリーンショット 2024-03-28 23 57 09](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/f0c9d884-9889-43a5-bf32-303582d47ff4)

#### record_tags<br>
![スクリーンショット 2024-03-29 0 06 24](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/91a67597-aeda-48da-8e83-593663f783b1)

#### health_record_tags<br>
![スクリーンショット 2024-03-28 23 56 45](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/c63686d7-c971-4b27-801e-8069afdcb52c)

#### admins<br>
![スクリーンショット 2024-04-23 15 22 46](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/d7ef70a7-b101-486a-9bb9-dc226459db6e)

### テスト仕様書
<br><br>
#### ユーザー<br>

![スクリーンショット 2024-03-29 0 21 34](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/9bc18553-7a79-4812-9a59-adaa94df4740)

![スクリーンショット 2024-03-29 0 21 55](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/f85636f6-d458-444a-bd20-0811f55ad5ff)

#### 管理者<br>
![スクリーンショット 2024-03-29 0 22 03](https://github.com/mountainpaddy040818/WellnessJourney2/assets/153415348/aaffad5d-fb44-4334-8b3a-45d4278b462f)


## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## インストール方法
- git clone git@github.com:mountainpaddy040818/WellnessJourney.git
- cd WellnessJourney
- yarn install
- bundle install
- rails db:migrate
- rails s
- Preview

## 作成者
### 山田　明弘
