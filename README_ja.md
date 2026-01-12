# future: Rにおける統一的な並列分散処理

*This is a translation of
[README.md](https://github.com/futureverse/future/blob/develop/README.md)
as of
[2023-06-17](https://github.com/futureverse/future/blob/2a675abff2e3a729e6108d40710d0dcb22cc705b/README.md)
done by [hoxo_m](https://github.com/hoxo-m).*

[![CRAN check
status](https://www.r-pkg.org/badges/version/future)](https://CRAN.R-project.org/web/checks/check_results_future.html)
[![R CMD check
status](https://github.com/futureverse/future/actions/workflows/R-CMD-check.yaml/badge.svg?branch=develop)](https://github.com/futureverse/future/actions?query=workflow%3AR-CMD-check)
[![Top reverse-dependency checks
status](https://github.com/futureverse/future/actions/workflows/revdepcheck-top.yaml/badge.svg?branch=develop)](https://github.com/futureverse/future/actions?query=workflow%3Arevdepcheck-top)
[![future.tests checks
status](https://github.com/futureverse/future/actions/workflows/future_tests.yaml/badge.svg?branch=develop)](https://github.com/futureverse/future/actions?query=workflow%3Afuture_tests)
[![Coverage
Status](https://codecov.io/gh/futureverse/future/branch/develop/graph/badge.svg)](https://app.codecov.io/gh/futureverse/future)

## イントロダクション

[future](https://cran.r-project.org/package=future) パッケージは、R の式
(expression) を非同期的に実行するためのシンプルな方法を提供する。
また、非同期処理に使われる様々なリソースを一貫した方法で取り扱うことができる。

**フューチャ (future)**
はプログラミング用語であり、「未来のある時点で利用可能になる予定の**値
(value)**」を表す抽象的な概念である。
フューチャは状態をもち、**解決済み**か**未解決**かのどちらかの状態をとる。
フューチャが解決済み状態の場合、そのフューチャの値はすぐに利用できる。
一方、フューチャが未解決状態の場合、そのフューチャの値を利用しようとすると、フューチャの状態が解決済みになるまでプロセスは**ブロック**される。
ただし、ブロックされずにフューチャの状態を確認する方法も用意されている。
いつどのようにフューチャが解決されるかは、式の評価に使われる**戦略
(strategy)** によって異なる。
例えば、フューチャを解決する戦略の1つに逐次戦略がある。
この戦略は、フューチャを現行の R セッションで解決しようとする。
また、フューチャを非同期的に解決する戦略として、1台のコンピュータ上で式の並列評価を行う戦略や、計算クラスタ上で一斉に式を評価する戦略などがある。

フューチャがどのように動作するか例を示そう。
まず、フューチャを使わずに式を評価する次のコードを見てみよう。

``` r
> v <- {
+   cat("Hello world!\n")
+   3.14
+ }
Hello world!
> v
[1] 3.14
```

上のコードは式の値を変数 `v` に代入し、次に `v` の値を表示している。
このとき、`v`
の式が評価される際にメッセージも表示されることに注意しよう。

上のコードをフューチャを使った式に書き換えよう。

``` r
> library(future)
> v %<-% {
+   cat("Hello world!\n")
+   3.14
+ }
> v
Hello world!
[1] 3.14
```

2つのコード違いは `v` に対する代入記号にある。 最初のコードで `<-`
が使われていたところが、フューチャの場合は `%<-%` に変わっている。
もう1つの違いは、`Hello World!`
がフューチャが解決された**あと**、すなわち値が要求されたときに表示される（ビネット
[‘Outputting
Text’](https://cran.r-project.org/web/packages/future/vignettes/future-2-output.html)
を参照）。

フューチャは何が便利なのだろうか？
式をフューチャにしておくと、式の評価を非同期実行したいときに、次のように簡単に切り替えることができる。

``` r
> library(future)
> plan(multisession)
> v %<-% {
+   cat("Hello world!\n")
+   3.14
+ }
> v
Hello world!
[1] 3.14
```

非同期化されたフューチャは、実行時に現行のメインプロセスを**ブロックしない**。
つまり、バックグラウンドの別のプロセスでフューチャが解決されている間に、現行のプロセスで引き続き処理を実行できる。
このように、フューチャは、R
における並列分散処理のためのシンプルで強力な実行方法を提供するのである。

以降では future パッケージが提供する機能の詳細について説明していく。
その前に、とりあえず試してみたいという人は、先に終わりの方のセクション「デモ」を読んで、マンデルブロ集合を様々な戦略で描画してみると良いだろう。

## フューチャの作成

future
パッケージには、フューチャを作成する方法として、**明示的な**スタイルと**非明示的な**スタイルの2種類がある。
上記の例では、`v %<-% { 式 }`
という非明示的なスタイルでフューチャを作成した。
一方、明示的にフューチャを作成する方法として `f <- future({ 式 })` と
`v <- value(f)` という2つの関数を使うスタイルがある。
上記の例を明示的なスタイルに書き換えると次のようになる。

``` r
> library(future)
> f <- future({
+   cat("Hello world!\n")
+   3.14
+ })
> v <- value(f)
Hello world!
> v
[1] 3.14
```

どちらのスタイルで作成してもフューチャの動作は同じである(\*)。
非明示的なスタイルを使うと通常の R コードに近い書き方になる。
この場合、原則的に、フューチャの作成は `<-` で代入していたところを
`%<-%` に置き換えるだけである。
しかし、このシンプルさの欠点として、コードを読む際に、コード内で非同期フューチャが使用されていることに気づかない可能性がある。
明示的なスタイルならば、フューチャが使用されていることが明確になり、こうした見逃しのリスクは軽減されるため、コードを読む人に優しい。

(\*) 少し変更しないと `%<-%` が使えない場合がある。
この話題には、下の方のセクション「非明示的フューチャの制約」で触れる。

フューチャを作成する明示的なスタイルを正式に述べると次のようになる。

- `f <- future({ 式 })` – フューチャの作成
- `v <- value(f)` – フューチャから値を取得する
  (未解決の場合は解決されるまでプロセスはブロックされる)

また、非明示的なスタイルは次のようになる。

- `v %<-% { 式 }` – フューチャを作成し、その値のプロミスを作成する

以降では、コードを簡潔にするためにフューチャの作成には非明示的なスタイルを使う。
ただし、議論されているすべてのことが明示的なスタイルで作成されたフューチャに対しても同様に成り立つ。

## 戦略：フューチャの解決方法を決める

future パッケージで利用できる戦略を次の表に示す。

| 名前           | OS                      | 説明                                                  |
|:---------------|:------------------------|:------------------------------------------------------|
| ***同期:***    |                         | ***非並列:***                                         |
| `sequential`   | すべて                  | 逐次的かつ現行のRプロセス                             |
| ***非同期:***  |                         | ***並列:***                                           |
| `multisession` | すべて                  | バックグラウンド R セッション（現行のマシン上）       |
| `multicore`    | Windows以外/RStudio以外 | フォークされた R プロセス（現行のマシン上）           |
| `cluster`      | すべて                  | 外部 R セッション（現行、ローカル、リモートマシン上） |

future
パッケージは、自分で実装した戦略を追加できるように設計されている。
例えば、[future.callr](https://cran.r-project.org/package=future.callr)
パッケージは、[callr](https://cran.r-project.org/package=callr)
パッケージを利用してバックグラウンドの R
プロセスでフューチャを評価するバックエンドを提供する。 これは
`multisession` 戦略と似ているが、いくつかの利点がある。
また、[future.batchtools](https://cran.r-project.org/package=future.batchtools)
パッケージは、[batchtools](https://cran.r-project.org/package=batchtools)
パッケージがサポートするすべてのクラスタ関数に対するフューチャバックエンドを提供する。
具体的には、Slurm、TORQUE/PBS、Oracle/Sun Grid Engine (SGE)、Load
Sharing Facility (LSF) などのジョブスケジューラを使用して R
の式を評価するフューチャがある。

デフォルトでは、フューチャの式はその場で同期的に（現行のRセッションで）評価される。
このデフォルトの戦略は逐次 (sequential) 戦略と呼ばれる。
このセクションでは、future
パッケージで利用できるそれぞれの戦略について説明し、共通点と相違点について述べる。

### フューチャに共通のふるまい

それぞれの戦略の説明に進む前に、future パッケージが提供する API (Future
API) の設計について理解しよう。 Future API
はユーザがどの戦略を使っても同じふるまいをするように設計されている。
なぜなら、ユーザが実際にどんな計算リソースを使うかについてあらかじめ知ることができないからである。
これにより、Future API
は、ユーザが使用する戦略について、同期か非同期かなどのいかなる仮定もおかずに利用できる。

Future API
は、その動作が戦略に依存しないように、あらゆる違いをカプセル化するように設計されている。
フューチャの式が現行の R セッションで評価されようが、リモートの R
セッションで評価されようが関係なく、どのフューチャ戦略に対しても一貫した
API とふるまいを持つ。
これにより、フューチャを使ってプログラミングするとき、ユーザはどの戦略を使うかを気にしなくてすむ。
また、この設計のもう1つの利点は、プロトタイピングしやすいことにある。
非同期処理のスクリプトを書く際に、最初はデバッグしやすい逐次戦略を使用して書き、実際の処理のときに簡単に非同期処理へ切り替えることができる。

そのために、すべての戦略は、フューチャの式の評価結果と副作用が可能な限り同じになるように作られている。
具体的には、すべてのフューチャ戦略は以下を満たす。

- 式の評価は**ローカル環境**（すなわち
  `local({ 式 })`）で行われる。したがって、代入文は呼び出し環境に影響を与えない。
  これは評価が外部の R プロセスで行われるときはもちろん、現行の R
  セッションで行われるときにも適用される。
- フューチャの作成時に、**グローバル変数が固定される**。
  非同期評価の場合、グローバル変数は、フューチャの式を評価する R
  プロセスにエクスポートされる。 遅延評価 (`lazy = TRUE`)
  を伴う逐次戦略においては、グローバル変数はフリーズ（フューチャのローカル環境にクローン）される。
  また、誤って大きすぎるオブジェクトをエクスポートすることを防ぐために、グローバル変数の合計サイズにしきい値を設定できる。このしきい値を超えるとエラーが発生する（[`help("future.options")`](https://future.futureverse.org/reference/zzz-future.options.md)
  を参照）。
- フューチャの式の評価は一度だけ実行される。
  値が定まった（解決済み状態になった）あとで、同じフューチャをもう一度評価することはできない。

代入がローカル環境で実行される（グローバル環境に影響しない）ことは、次のコードの実行結果からわかる。

``` r
> plan(sequential)
> a <- 1
> x %<-% {
+     a <- 2
+     2 * a
+ }
> x
[1] 4
> a
[1] 1
```

以上で、フューチャに共通するふるまいがわかった。
以降ではそれぞれのフューチャ戦略について見ていく。

### 同期的フューチャ

同期的フューチャはフューチャを作成した R
プロセスで一つひとつ解決される。
同期的フューチャが解決されている間、メインプロセスはブロックされる。

#### 逐次的フューチャ (Sequential Future)

逐次的フューチャはデフォルトのフューチャである。 Future API
の共通のふるまいを満たしながら、通常の R
評価と同じように動作するように設計されている。
逐次的フューチャのふるまいを次のコードに示す。

``` r
> plan(sequential)
> pid <- Sys.getpid()
> pid
[1] 1427324
> a %<-% {
+     pid <- Sys.getpid()
+     cat("Future 'a' ...\n")
+     3.14
+ }
> b %<-% {
+     rm(pid)
+     cat("Future 'b' ...\n")
+     Sys.getpid()
+ }
> c %<-% {
+     cat("Future 'c' ...\n")
+     2 * a
+ }
Future 'a' ...
> b
Future 'b' ...
[1] 1427324
> c
Future 'c' ...
[1] 6.28
> a
[1] 3.14
> pid
[1] 1427324
```

逐次的な評価がその場で行われるため、3つのフューチャは作成と同時に即座に解決される。
呼び出し環境の `pid`（これは現行プロセスのプロセス ID
が代入されている）は上書きも削除もされないことに注意しよう。
これはフューチャがローカル環境で評価されるためである。
同期的な（単一の）プロセスが評価に使われるので、フューチャ `b`
はメインの R プロセスによって（ローカル環境で）解決される 。 これが `b`
の値と `pid` が一致する理由である。

### 非同期的フューチャ

非同期的フューチャの説明に移ろう。
非同期的フューチャは、バックグラウンドで処理されるフューチャである。
設計上、これらのフューチャはノンブロッキングである。
すなわち、フューチャを作成したとき、呼び出し側のプロセスは他のタスク（さらにフューチャを作るなど）に利用できる。
呼び出し側のプロセスがブロックされるのは、未解決のフューチャの値にアクセスを試みた場合か、すべての利用可能な
R
プロセスが他のフューチャでビジーになっているときにさらに非同期のフューチャを作成しようとした場合に限られる。

#### マルチセッションフューチャ (Multisession Future)

すべての OS で提供されているマルチセッションフューチャから始めよう。
マルチセッションフューチャは呼び出し側の R
プロセスと同じマシンで、バックグラウンドの R
セッションにおいてフューチャを評価する。
マルチセッション評価の例を示そう。

``` r
> plan(multisession)
> pid <- Sys.getpid()
> pid
[1] 1427324
> a %<-% {
+     pid <- Sys.getpid()
+     cat("Future 'a' ...\n")
+     3.14
+ }
> b %<-% {
+     rm(pid)
+     cat("Future 'b' ...\n")
+     Sys.getpid()
+ }
> c %<-% {
+     cat("Future 'c' ...\n")
+     2 * a
+ }
Future 'a' ...
> b
Future 'b' ...
[1] 1427382
> c
Future 'c' ...
[1] 6.28
> a
[1] 3.14
> pid
[1] 1427324
```

この結果を見ると、`a`, `c`, `pid`
の値は逐次的フューチャのときと同じであり、`b` だけが異なることがわかる。
その理由は、フューチャ `b` は現行とは別の R
プロセスで評価され、そのプロセス ID を返すからである。

マルチセッション戦略を使うと、現行とは別の R
セッションがバックグラウンドで起動され、フューチャは作成と同時にそれらの
R セッションで評価される。
もしすべてのバックグラウンドセッションが他のフューチャでビジーならば、新しく作成されたマルチセッションフューチャはバックグラウンドセッションが利用可能になるまで**ブロックされる**。
いくつのバックグラウンドプロセスが起動されるかは
[`availableCores()`](https://future.futureverse.org/reference/re-exports.md)
の値によって決まる。

``` r
> availableCores()
mc.cores 
       2 
```

この結果から、メインプロセス以外に
2つのプロセスが利用可能なことがわかる。
したがって、この設定では、マルチセッションフューチャは
2つのバックグラウンドプロセスを使うことができる。 この値は `mc.cores`
オプションで変更できる。
[`availableCores()`](https://future.futureverse.org/reference/re-exports.md)
はさまざまなオプションやシステム環境にも対応している。
例えば、計算クラスタスケジューラ（例えば TORQUE/PBS や
Slurm）を使用する場合、与えられたジョブに割り当てられたコア数を指定するための環境変数を設定する。
その場合も
[`availableCores()`](https://future.futureverse.org/reference/re-exports.md)
はそのコア数を認識する。
何も指定しない場合、マシン上の利用可能なすべてのコアが使われる。
このデフォルトの値は
[`parallel::detectCores()`](https://rdrr.io/r/parallel/detectCores.html)
で確認できる。 詳細については
[`help("availableCores", package = "parallelly")`](https://parallelly.futureverse.org/reference/availableCores.html)
を参照してほしい。

#### マルチコアフューチャ (Multicore Future)

R がプロセスの**フォーク (forking)** をサポートしている OS（基本的には
Windows 以外）では、バックグラウンドで R
セッションを作成する代わりに、既存の R
プロセスをフォークすることができる。
フォークがサポートされている場合、次のようにしてマルチコアフューチャを使用することができる。

``` r
plan(multicore)
```

マルチセッションフューチャと同じように、並列に実行できるプロセスの最大値は
[`availableCores()`](https://future.futureverse.org/reference/re-exports.md)
によって決まる。 どちらの場合も評価はローカルマシン上で行われる。

フォークされた R プロセスでの実行は、バックグラウンド R
セッションでの実行より速くなる。
その理由の1つは、フォークではメモリを共有するため、バックグラウンドセッションに大きなグローバル変数をエクスポートすることによるオーバーヘッドが無くなることにある。
一方、共有メモリは**読み取り専用**である。
つまり、フォークされたプロセス（ワーカ）が共有オブジェクトを変更しようとするとコピーを引き起こす。
これは、R
のガベージコレクタが、フォークされたプロセスの1つで実行された場合にも生じる。

また、プロセスのフォークは R 環境によっては不安定である。
例えば、RStudio のプロセス内から R
を実行しているときにフォークを行うと、 R
セッションがクラッシュする可能性がある。 このため、future
パッケージでは、RStudio
上でマルチコアフューチャの使用をデフォルトで無効にしている。 詳細は
[`help("supportsMulticore")`](https://future.futureverse.org/reference/re-exports.md)
を参照してほしい。

#### クラスタフューチャ (Cluster Future)

クラスタフューチャは、（parallel
パッケージで実装されているような）アドホッククラスタ上で式を評価する。
例えば、3つのクラスタノード `n1`, `n2`, `n3`
があるとき、それらを使って非同期処理を行うには次のようにする。

``` r
> plan(cluster, workers = c("n1", "n2", "n3"))
> pid <- Sys.getpid()
> pid
[1] 1427324
> a %<-% {
+     pid <- Sys.getpid()
+     cat("Future 'a' ...\n")
+     3.14
+ }
> b %<-% {
+     rm(pid)
+     cat("Future 'b' ...\n")
+     Sys.getpid()
+ }
> c %<-% {
+     cat("Future 'c' ...\n")
+     2 * a
+ }
Future 'a' ...
> b
Future 'b' ...
[1] 1427499
> c
Future 'c' ...
[1] 6.28
> a
[1] 3.14
> pid
[1] 1427324
```

[`parallel::makeCluster()`](https://rdrr.io/r/parallel/makeCluster.html)
で作られたクラスタなら何でもクラスタフューチャで利用できる。
例えば、上記のクラスタを明示的にセットアップするには次のように書く。

``` r
cl <- parallel::makeCluster(c("n1", "n2", "n3"))
plan(cluster, workers = cl)
```

クラスタ `cl` がもう使われなくなったとき、`parallel::stopCluster(cl)`
を実行してクラスタをシャットダウンするのが良い作法である。
便利なことに、future
パッケージは、メインプロセスが終了したときに、クラスタを自動でシャットダウンしてくれる。
クラスタのセットアップや管理については
[`help("makeCluster", package = "parallel")`](https://rdrr.io/r/parallel/makeCluster.html)
を参照してほしい。 `plan(cluster, workers = hosts)`（`hosts`
には文字列が入る）で非明示的に作られたクラスタも、メインの R
セッションが終了するとシャットダウンされる。
また、フューチャ戦略が変更されたとき（例えば `plan(sequential)`
が呼ばれたとき）もクラスタはシャットダウンされる。

SSH
キーペアなどの自動認証設定があるなら、リモートマシンのクラスタが同じ方法で使用できる。

各ノードで複数のワーカを実行したい場合は、次のようにノード名を複数回書けばよい。

    > plan(cluster, workers = c(rep("n1", times = 3), "n2", rep("n3", times = 5)))

この例では、`n1` では3つ、`n2` では1つ、`n3`
では5つと、合計9つのワーカにより並列実行される。

### フューチャのネストと評価トポロジー

ここまでの説明では、フューチャは同じ環境で作成されていた。
これは「フラットトポロジー」と言うことができる。
しかし、フューチャの内部でフューチャを作成することもできる。
これを「ネストトポロジー」と呼ぶ。

例えば、次の例では、2つの「トップ」フューチャ（`a` と
`b`）があり、マルチセッション戦略を使って評価される。 ただし、フューチャ
`b` は内部に別のフューチャが使われている。

``` r
> plan(multisession)
> pid <- Sys.getpid()
> a %<-% {
+     cat("Future 'a' ...\n")
+     Sys.getpid()
+ }
> b %<-% {
+     cat("Future 'b' ...\n")
+     b1 %<-% {
+         cat("Future 'b1' ...\n")
+         Sys.getpid()
+     }
+     b2 %<-% {
+         cat("Future 'b2' ...\n")
+         Sys.getpid()
+     }
+     c(b.pid = Sys.getpid(), b1.pid = b1, b2.pid = b2)
+ }
> pid
[1] 1427324
> a
Future 'a' ...
[1] 1427606
> b
Future 'b' ...
Future 'b1' ...
Future 'b2' ...
  b.pid  b1.pid  b2.pid
1427607 1427607 1427607
```

プロセスIDを見ると、3つの異なるプロセスがフューチャの解決に使われていることがわかる。
メインプロセス (pid 1427324)、`a` に使われるプロセス (pid 1427606)、`b`
に使われるプロセス (pid 1427607) である。 しかし、`b`
にネストされている2つのフューチャ `b1` と `b2` は `b`
と同じプロセスで評価されている。
これは、特に指定しない限り、ネストされたフューチャは逐次戦略を使って評価されるためである。
これにはいくつかの理由があるが、主な理由は、再帰呼び出しなどによって、誤って多くのバックグラウンドプロセスが発生するのを防ぐためである。

[`plan()`](https://future.futureverse.org/reference/plan.md)
に戦略のリストを渡すことで、**評価トポロジー**を指定することができる。
例えば、上記と同じ評価トポロジーを明示的に指定するには次のようにする。

``` r
plan(list(multisession, sequential))
```

しかし、次に示すように、複数レベルのマルチセッション評価を試しても、上記と同じ動作になる。

``` r
> plan(list(multisession, multisession))
[...]
> pid
[1] 1427324
> a
Future 'a' ...
[1] 1427721
> b
Future 'b' ...
Future 'b1' ...
Future 'b2' ...
  b.pid  b1.pid  b2.pid
1427722 1427722 1427722
```

この理由は、ここでも、誤って多くのプロセスが起動するのを防ぐためである。
内部的には、[`parallel::mclapply()`](https://rdrr.io/r/parallel/mclapply.html)
のような関数が逐次実行されるように `mc.core = 1` が設定される。
これはマルチセッション評価とマルチコア評価の両方で起こる。

次に、トップレベルを逐次評価にして、ネストされたフューチャをマルチセッション評価してみよう。

``` r
> plan(list(sequential, multisession))
[...]
> pid
[1] 1427324
> a
Future 'a' ...
[1] 1427324
> b
Future 'b' ...
Future 'b1' ...
Future 'b2' ...
  b.pid  b1.pid  b2.pid
1427324 1427855 1427854
```

`a` と `b` は呼び出しプロセス (pid 1427324)
で解決され、ネストされた2つのフューチャ（`b1` と
`b2`）はそれぞれ別のプロセス (pid 1427855 と 1427854)
で解決されることがわかる。

各レベルで利用可能なコアの数を明示的に指定する（**強制する**）と、ネストされたマルチセッション評価戦略を使用することができる。
そのためには、次のようにしてデフォルト設定を “tweak” する必要がある。

``` r
> plan(list(tweak(multisession, workers = 2), tweak(multisession, 
+     workers = 2)))
[...]
> pid
[1] 1427324
> a
Future 'a' ...
[1] 1427973
> b
Future 'b' ...
Future 'b1' ...
Future 'b2' ...
  b.pid  b1.pid  b2.pid
1427972 1428098 1428099
```

まず、`a` と `b` は呼び出しプロセス (pid 1427324)
とは異なるプロセス（pid 1427973 と 1427972）で解決される。
次に、2つのネストされたフューチャ（`b1` と
`b2`）もまた異なるプロセス（pid 1428098 と 1428099）で解決される。

ネストされたフューチャの各レベルで異なる評価戦略を使う方法についての詳細は、ビネット
[‘Futures in R: Future
Topologies’](https://cran.r-project.org/web/packages/future/vignettes/future-3-topologies.html)
を参照してほしい。

### ブロックされずにフューチャの状態を確認する

フューチャが解決済みか未解決かをブロックされずに確認する方法がある。
これには `resolved(f)` 関数を使う。
この関数には入力として明示的なフューチャ `f` を与える。
もし非明示的なフューチャを使っている場合、`f <- futureOf(a)`
のようにして非明示的なフューチャを明示的なフューチャに変換する必要がある。
例を次に示す。

``` r
> plan(multisession)
> a %<-% {
+     cat("Future 'a' ...")
+     Sys.sleep(2)
+     cat("done\n")
+     Sys.getpid()
+ }
> cat("Waiting for 'a' to be resolved ...\n")
Waiting for 'a' to be resolved ...
> f <- futureOf(a)
> count <- 1
> while (!resolved(f)) {
+     cat(count, "\n")
+     Sys.sleep(0.2)
+     count <- count + 1
+ }
1 
2 
3 
4 
5 
> cat("Waiting for 'a' to be resolved ... DONE\n")
Waiting for 'a' to be resolved ... DONE
> a
Future 'a' ...done
[1] 1428185
```

## フューチャにおけるエラー処理

フューチャが期待通りに動かない場合がある。
フューチャを評価しているときにエラーが起こった場合、そのエラーは**フューチャの値が要求されたとき**に呼び出し環境へ伝播される。
例えば、遅延評価を使ったフューチャでエラーが起こった場合、次のようになる。

``` r
> plan(sequential)
> b <- "hello"
> a %<-% {
+     cat("Future 'a' ...\n")
+     log(b)
+ } %lazy% TRUE
> cat("Everything is still ok although we have created a future that will fail.\n")
Everything is still ok although we have created a future that will fail.
> a
Future 'a' ...
Error in log(b) : non-numeric argument to mathematical function
```

このエラーは値を要求するたびに起こる。
すなわち、もう一度値を取得しようとすると同じエラー（と出力）になる。

``` r
> a
Future 'a' ...
Error in log(b) : non-numeric argument to mathematical function
In addition: Warning message:
restarting interrupted promise evaluation
```

エラーを起こしたコールスタックの**最後の**呼び出しを見るには、[`backtrace()`](https://future.futureverse.org/reference/backtrace.md)
関数(\*)を使う。

``` r
> backtrace(a)
[[1]]
log(a)
```

(\*) 一般的に使用される
[`traceback()`](https://rdrr.io/r/base/traceback.html)
はフューチャの場合には関連情報を提供しない。
さらに、残念ながら、エラーの原因となった呼び出しのリストを見ることはできない。
エラーを起こした呼び出しだけを見ることができる（これは内部で使われる
[`tryCatch()`](https://rdrr.io/r/base/conditions.html) の制約である）。

## グローバルオブジェクト

R
の式を非同期的に（並列に）評価するとき、または遅延評価で逐次評価するときは、グローバルオブジェクト（「フリー」オブジェクトとも言う）を特定して渡す必要がある。
遅延評価では、グローバルオブジェクトはフューチャの作成時と評価時で変更されている可能性があるため、フューチャの作成時とまったく同じ状態で渡す必要がある。
非同期評価では、フューチャを評価するプロセスにグローバルオブジェクトをエクスポートするために、それらを特定する必要がある。

future パッケージではこれをできる限り自動化している。
そのために静的コード解析によってグローバル変数を特定する
[globals](https://cran.r-project.org/package=globals)
パッケージが使われる。
グローバル変数が特定されると、キャプチャされ、評価プロセスで利用可能になる。
また、パッケージ内でグローバル変数が定義されている場合、それらはエクスポートされない。
かわりに、フューチャが評価されるときに対応するパッケージが確実に読み込まれているようにする。
これはメイン R
セッションの設定をよりよく反映するだけでなく、グローバルオブジェクトのエクスポートの必要性も最小限に抑える。
これにより、特にリモートの計算ノードを使用する場合、メモリだけでなく時間と帯域幅も節約できる。

最後に、静的コード解析だけではグローバル変数を特定するのは難しいということを述べておこう。
グローバル変数の自動識別に失敗するケースが常に存在する。
そのため、間違ってグローバル判定してしまう場合（これは特に問題にならない）と、グローバル変数を見逃してしまう場合（この場合はエラーか間違った結果になる）がある。
ビネット [‘Futures in R: Common Issues with
Solutions’](https://cran.r-project.org/web/packages/future/vignettes/future-4-issues.html)
では、そのようなケースの一般的な例や、避けるにはどうすればいいか、また、どのようにグローバル変数が特定されるかや間違って特定したグローバル変数を無視する方法を説明している。
それでも十分でない場合、グローバル変数の名前を指定する（例：`globals = c("a", "slow_sum")`）か、名前と値のペアで指定する（例：`globals = list(a = 42, slow_sum = my_sum)`）ことができる。

## 非明示的フューチャの制約

非明示的なフューチャには1つの制約がある。 明示的なフューチャは単なる R
オブジェクトなので、どこでも何にでも代入可能である。
例えば、次のように、ループの中でフューチャをリストの要素として代入できる。

``` r
> plan(multisession)
> f <- list()
> for (ii in 1:3) {
+     f[[ii]] <- future({
+         Sys.getpid()
+     })
+ }
> v <- lapply(f, FUN = value)
> str(v)
List of 3
 $ : int 1428291
 $ : int 1428290
 $ : int 1428291
```

これは非明示的なフューチャでは**できない**。 なぜなら、`%<-%`
演算子は通常の `<-` 代入演算子とは違う動作をするからである。 `%<-%`
演算子はフューチャの値を**環境**（呼び出し環境など）に代入する。 これは
`assign(name, value, envir)` と同じ動作である。
したがって、上記と同様のことを非明示的フューチャで行いたい場合は、次のように名前インデックスを使って環境に代入する。

``` r
> plan(multisession)
> v <- new.env()
> for (name in c("a", "b", "c")) {
+     v[[name]] %<-% {
+         Sys.getpid()
+     }
+ }
> v <- as.list(v)
> str(v)
List of 3
 $ a: int 1428405
 $ b: int 1428406
 $ c: int 1428405
```

ここで、`as.list(v)` は環境 `v`
のすべてのフューチャが解決するまでブロックされる。
その後、フューチャの値は通常のリストとして返される。

もし**数値インデックス**を使いたい場合は、[listenv](https://cran.r-project.org/package=listenv)
パッケージで提供されている**リスト環境**を使えばよい。
リスト環境は、インデックス付きリストと同じように、インデックス付けすることができる環境である。
上記のコードでリストをリスト環境に置き換えると、数値インデックスを使って非明示的フューチャを代入できるようになる。

``` r
> library(listenv)
> plan(multisession)
> v <- listenv()
> for (ii in 1:3) {
+     v[[ii]] %<-% {
+         Sys.getpid()
+     }
+ }
> v <- as.list(v)
> str(v)
List of 3
 $ : int 1428523
 $ : int 1428522
 $ : int 1428523
```

ここでも、`as.list(v)`
はすべてのフューチャが解決するまでブロックされる。

## デモ

様々な戦略においてフューチャがどのように評価されるかの実例を見るには、このパッケージに含まれるマンデルブロ
(Mandelbrot) デモを実行するとよい。 まず、逐次評価で実行してみよう。

``` r
library(future)
plan(sequential)
demo("mandelbrot", package = "future", ask = FALSE)
```

これはフューチャを使用しない場合の動作とほとんど同じである。
次に、マルチセッション評価を試してみよう。
これは異なるマンデルブロ平面をバックグラウンドで実行される R
プロセスで並列に計算する。

``` r
plan(multisession)
demo("mandelbrot", package = "future", ask = FALSE)
```

最後に、複数の計算機にアクセスできる場合、クラスタのワーカを指定して実行できる。

``` r
plan(cluster, workers = c("n2", "n5", "n6", "n6", "n9"))
demo("mandelbrot", package = "future", ask = FALSE)
```

## 貢献するには

このパッケージの目的は、R でフューチャを使うための標準的で統一された API
を提供することである。
現状はこの目的を達成するための初期段階にすぎない。 future
パッケージを改善するアイデアや意見を持っている人がいたらぜひ教えてほしい。
開発者に連絡をとるには [GitHub
リポジトリ](https://github.com/futureverse/future/)経由が好ましいが、どのような手段であっても歓迎する。

## インストール

future パッケージは CRAN
で利用可能であり、次のコードを実行してインストールできる。

``` r
install.packages("future")
```

### プレリリースバージョンのインストール

プレリリースバージョンは GitHub の `develop`
ブランチにあり、インストールするには次のようにする。

``` r
remotes::install_github("futureverse/future", ref="develop")
```

これはソースからのインストールとなる。

## 貢献

このパッケージに貢献するには、[CONTRIBUTING.md](https://future.futureverse.org/CONTRIBUTING.md)
を参照してほしい。
