_This is a translation of [README.md](https://github.com/futureverse/future/blob/develop/README.md) as of [2023-06-17](https://github.com/futureverse/future/blob/2a675abff2e3a729e6108d40710d0dcb22cc705b/README.md) done by [hoxo_m](https://github.com/hoxo-m)._

<div id="badges"><!-- pkgdown markup -->
<a href="https://CRAN.R-project.org/web/checks/check_results_future.html"><img border="0" src="https://www.r-pkg.org/badges/version/future" alt="CRAN check status"/></a> <a href="https://github.com/futureverse/future/actions?query=workflow%3AR-CMD-check"><img border="0" src="https://github.com/futureverse/future/actions/workflows/R-CMD-check.yaml/badge.svg?branch=develop" alt="R CMD check status"/></a> <a href="https://github.com/futureverse/future/actions?query=workflow%3Arevdepcheck-top"><img border="0" src="https://github.com/futureverse/future/actions/workflows/revdepcheck-top.yaml/badge.svg?branch=develop" alt="Top reverse-dependency checks status"/></a> <a href="https://github.com/futureverse/future/actions?query=workflow%3Afuture_tests"><img border="0" src="https://github.com/futureverse/future/actions/workflows/future_tests.yaml/badge.svg?branch=develop" alt="future.tests checks status"/></a>   <a href="https://app.codecov.io/gh/futureverse/future"><img border="0" src="https://codecov.io/gh/futureverse/future/branch/develop/graph/badge.svg" alt="Coverage Status"/></a> 
</div>

# future: Rにおける統一的な並列分散処理 <img border="0" src="man/figures/logo.png" alt="The 'future' hexlogo" align="right" />

## イントロダクション

<!--
The purpose of the future package is to provide a very simple and uniform way of evaluating R expressions asynchronously using various resources available to the user.
-->

[future](https://cran.r-project.org/package=future) パッケージは、R の式
(expression) を非同期的に実行するためのシンプルな方法を提供する。
また、非同期処理に使われる様々なリソースを一貫した方法で取り扱うことができる。

<!--
In programming, a future is an abstraction for a value that may be available at some point in the future.
The state of a future can either be unresolved or resolved. 
As soon as it is resolved, the value is available instantaneously.
If the value is queried while the future is still unresolved, the current process is blocked until the future is resolved.
It is possible to check whether a future is resolved or not without blocking. 
Exactly how and when futures are resolved depends on what strategy is used to evaluate them. 
For instance, a future can be resolved using a sequential strategy, which means it is resolved in the current R session.
Other strategies may be to resolve futures asynchronously, for instance, by evaluating expressions in parallel on the current machine or concurrently on a compute cluster.
-->

**フューチャ (future)** はプログラミング用語であり、「未来のある時点で利用可能になる予定の**値
(value)**」を表す抽象的な概念である。
フューチャは状態をもち、**解決済み**か**未解決**かのどちらかの状態をとる。
フューチャが解決済み状態の場合、そのフューチャの値はすぐに利用できる。
一方、フューチャが未解決状態の場合、そのフューチャの値を利用しようとすると、フューチャの状態が解決済みになるまでプロセスは**ブロック**される。
ただし、ブロックされずにフューチャの状態を確認する方法も用意されている。 いつどのようにフューチャが解決されるかは、式の評価に使われる**戦略
(strategy)** によって異なる。 例えば、フューチャを解決する戦略の1つに逐次戦略がある。 この戦略は、フューチャを現行の R
セッションで解決しようとする。
また、フューチャを非同期的に解決する戦略として、1台のコンピュータ上で式の並列評価を行う戦略や、計算クラスタ上で一斉に式を評価する戦略などがある。

<!--
Here is an example illustrating how the basics of futures work.
First, consider the following code snippet that uses plain R code:
-->

フューチャがどのように動作するか例を示そう。 まず、フューチャを使わずに式を評価する次のコードを見てみよう。

``` r
> v <- {
+   cat("Hello world!\n")
+   3.14
+ }
Hello world!
> v
[1] 3.14
```

<!--
It works by assigning the value of an expression to variable v and we then print the value of v. 
Moreover, when the expression for v is evaluated we also print a message.
-->

上のコードは式の値を変数 `v` に代入し、次に `v` の値を表示している。 このとき、`v`
の式が評価される際にメッセージも表示されることに注意しよう。

<!--
Here is the same code snippet modified to use futures instead:
-->

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

<!--
The difference is in how v is constructed; with plain R we use <- whereas with futures we use %<-%.
The other difference is that output is relayed after the future is resolved (not during) and when the value is queried (see Vignette 'Outputting Text').
-->

2つのコード違いは `v` に対する代入記号にある。 最初のコードで `<-` が使われていたところが、フューチャの場合は `%<-%`
に変わっている。 もう1つの違いは、`Hello World!`
がフューチャが解決された**あと**、すなわち値が要求されたときに表示される（ビネット
[‘Outputting
Text’](https://cran.r-project.org/web/packages/future/vignettes/future-2-output.html)
を参照）。

<!--
So why are futures useful? 
Because we can choose to evaluate the future expression in a separate R process asynchronously by simply switching settings as:
-->

フューチャは何が便利なのだろうか？ 式をフューチャにしておくと、式の評価を非同期実行したいときに、次のように簡単に切り替えることができる。

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

<!--
With asynchronous futures, the current/main R process does not block, which means it is available for further processing while the futures are being resolved in separate processes running in the background.
In other words, futures provide a simple but yet powerful construct for parallel and / or distributed processing in R.
-->

非同期化されたフューチャは、実行時に現行のメインプロセスを**ブロックしない**。
つまり、バックグラウンドの別のプロセスでフューチャが解決されている間に、現行のプロセスで引き続き処理を実行できる。
このように、フューチャは、R における並列分散処理のためのシンプルで強力な実行方法を提供するのである。

<!--
Now, if you cannot be bothered to read all the nitty-gritty details about futures, but just want to try them out, then skip to the end to play with the Mandelbrot demo using both parallel and non-parallel evaluation.
-->

以降では future パッケージが提供する機能の詳細について説明していく。
その前に、とりあえず試してみたいという人は、先に終わりの方のセクション「デモ」を読んで、マンデルブロ集合を様々な戦略で描画してみると良いだろう。

## フューチャの作成

<!--
Futures can be created either implicitly or explicitly. 
In the introductory example above we used implicit futures created via the v %<-% { expr } construct. 
An alternative is explicit futures using the f <- future({ expr }) and v <- value(f) constructs. With these, our example could alternatively be written as:
-->

future パッケージには、フューチャを作成する方法として、**明示的な**スタイルと**非明示的な**スタイルの2種類がある。
上記の例では、`v %<-% { 式 }` という非明示的なスタイルでフューチャを作成した。
一方、明示的にフューチャを作成する方法として `f <- future({ 式 })` と `v
<- value(f)` という2つの関数を使うスタイルがある。 上記の例を明示的なスタイルに書き換えると次のようになる。

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

<!--
Either style of future construct works equally(*) well. 
The implicit style is most similar to how regular R code is written. 
In principle, all you have to do is to replace <- with a %<-% to turn the assignment into a future assignment.
On the other hand, this simplicity can also be deceiving, particularly when asynchronous futures are being used. 
In contrast, the explicit style makes it much clearer that futures are being used, which lowers the risk for mistakes and better communicates the design to others reading your code.
-->

どちらのスタイルで作成してもフューチャの動作は同じである(\*)。 非明示的なスタイルを使うと通常の R コードに近い書き方になる。
この場合、原則的に、フューチャの作成は `<-` で代入していたところを `%<-%` に置き換えるだけである。
しかし、このシンプルさの欠点として、コードを読む際に、コード内で非同期フューチャが使用されていることに気づかない可能性がある。
明示的なスタイルならば、フューチャが使用されていることが明確になり、こうした見逃しのリスクは軽減されるため、コードを読む人に優しい。

<!--
(*) There are cases where %<-% cannot be used without some (small) modifications. 
We will return to this in Section 'Constraints when using Implicit Futures' near the end of this document.
-->

(\*) 少し変更しないと `%<-%` が使えない場合がある。 この話題には、下の方のセクション「非明示的フューチャの制約」で触れる。

<!--
To summarize, for explicit futures, we use:
- f <- future({ expr }) - creates a future
- v <- value(f) - gets the value of the future (blocks if not yet resolved)
-->

フューチャを作成する明示的なスタイルを正式に述べると次のようになる。

  - `f <- future({ 式 })` – フューチャの作成
  - `v <- value(f)` – フューチャから値を取得する (未解決の場合は解決されるまでプロセスはブロックされる)

<!--
For implicit futures, we use:
- v %<-% { expr } - creates a future and a promise to its value
-->

また、非明示的なスタイルは次のようになる。

  - `v %<-% { 式 }` – フューチャを作成し、その値のプロミスを作成する

<!--
To keep it simple, we will use the implicit style in the rest of this document, but everything discussed will also apply to explicit futures.
-->

以降では、コードを簡潔にするためにフューチャの作成には非明示的なスタイルを使う。
ただし、議論されているすべてのことが明示的なスタイルで作成されたフューチャに対しても同様に成り立つ。

## 戦略：フューチャの解決方法を決める

<!--
The future package implements the following types of futures:
-->

future パッケージで利用できる戦略を次の表に示す。

<!--
Name    OSes    Description
synchronous:        non-parallel:
sequential  all sequentially and in the current R process
asynchronous:       parallel:
multisession    all background R sessions (on current machine)
multicore   not Windows forked R processes (on current machine)
cluster all external R sessions on current, local, and remote machines
-->

| 名前             | OS                  | 説明                                                     |
| :------------- | :------------------ | :----------------------------------------------------- |
| ***同期:***      |                     | ***非並列:***                                             |
| `sequential`   | すべて                 | 逐次的かつ現行のRプロセス                                          |
| ***非同期:***     |                     | ***並列:***                                              |
| `multisession` | すべて                 | バックグラウンド R セッション（現行のマシン上）                              |
| `multicore`    | Windows以外/RStudio以外 | フォークされた R プロセス（現行のマシン上）                                |
| `cluster`      | すべて                 | 外部 R セッション（現行、ローカル、リモートマシン上）                           |

<!--
The future package is designed such that support for additional strategies can be implemented as well. 
For instance, the future.callr package provides future backends that evaluates futures in a background R process utilizing the callr package - they work similarly to multisession futures but has a few advantages. 
Continuing, the future.batchtools package provides futures for all types of cluster functions (“backends”) that the batchtools package supports. 
Specifically, futures for evaluating R expressions via job schedulers such as Slurm, TORQUE/PBS, Oracle/Sun Grid Engine (SGE) and Load Sharing Facility (LSF) are also available. 
-->

future パッケージは、自分で実装した戦略を追加できるように設計されている。
例えば、[future.callr](https://cran.r-project.org/package=future.callr)
パッケージは、[callr](https://cran.r-project.org/package=callr)
パッケージを利用してバックグラウンドの R
プロセスでフューチャを評価するバックエンドを提供する。 これは
`multisession` 戦略と似ているが、いくつかの利点がある。
また、[future.batchtools](https://cran.r-project.org/package=future.batchtools)
パッケージは、[batchtools](https://cran.r-project.org/package=batchtools)
パッケージがサポートするすべてのクラスタ関数に対するフューチャバックエンドを提供する。
具体的には、Slurm、TORQUE/PBS、Oracle/Sun Grid Engine (SGE)、Load
Sharing Facility (LSF) などのジョブスケジューラを使用して R の式を評価するフューチャがある。

<!--
By default, future expressions are evaluated eagerly (= instantaneously) and synchronously (in the current R session). 
This evaluation strategy is referred to as “sequential”.
In this section, we will go through each of these strategies and discuss what they have in common and how they differ.
-->

デフォルトでは、フューチャの式はその場で同期的に（現行のRセッションで）評価される。 このデフォルトの戦略は逐次 (sequential)
戦略と呼ばれる。 このセクションでは、future
パッケージで利用できるそれぞれの戦略について説明し、共通点と相違点について述べる。

### フューチャに共通のふるまい

<!--
Before going through each of the different future strategies, it is probably helpful to clarify the objectives the Future API (as defined by the future package). 
When programming with futures, it should not really matter what future strategy is used for executing code. 
This is because we cannot really know what computational resources the user has access to so the choice of evaluation strategy should be in the hands of the user and not the developer. 
In other words, the code should not make any assumptions on the type of futures used, e.g. synchronous or asynchronous.
-->

それぞれの戦略の説明に進む前に、future パッケージが提供する API (Future API) の設計について理解しよう。 Future
API はユーザがどの戦略を使っても同じふるまいをするように設計されている。
なぜなら、ユーザが実際にどんな計算リソースを使うかについてあらかじめ知ることができないからである。
これにより、Future API は、ユーザが使用する戦略について、同期か非同期かなどのいかなる仮定もおかずに利用できる。

<!--
One of the designs of the Future API was to encapsulate any differences such that all types of futures will appear to work the same. 
This despite expressions may be evaluated locally in the current R session or across the world in remote R sessions.
Another obvious advantage of having a consistent API and behavior among different types of futures is that it helps while prototyping. 
Typically one would use sequential evaluation while building up a script and, later, when the script is fully developed, one may turn on asynchronous processing.
-->

Future API は、その動作が戦略に依存しないように、あらゆる違いをカプセル化するように設計されている。 フューチャの式が現行の R
セッションで評価されようが、リモートの R セッションで評価されようが関係なく、どのフューチャ戦略に対しても一貫した API
とふるまいを持つ。 これにより、フューチャを使ってプログラミングするとき、ユーザはどの戦略を使うかを気にしなくてすむ。
また、この設計のもう1つの利点は、プロトタイピングしやすいことにある。
非同期処理のスクリプトを書く際に、最初はデバッグしやすい逐次戦略を使用して書き、実際の処理のときに簡単に非同期処理へ切り替えることができる。

<!--
Because of this, the defaults of the different strategies are such that the results and side effects of evaluating a future expression are as similar as possible. 
More specifically, the following is true for all futures:
-->

そのために、すべての戦略は、フューチャの式の評価結果と副作用が可能な限り同じになるように作られている。
具体的には、すべてのフューチャ戦略は以下を満たす。

<!--
- All evaluation is done in a local environment (i.e. local({ expr })) so that assignments do not affect the calling environment. 
This is natural when evaluating in an external R process, but is also enforced when evaluating in the current R session.
- When a future is constructed, global variables are identified. 
For asynchronous evaluation, globals are exported to the R process/session that will be evaluating the future expression. 
For sequential futures with lazy evaluation (lazy = TRUE), globals are “frozen” (cloned to a local environment of the future). 
Also, in order to protect against exporting too large objects by mistake, there is a built-in assertion that the total size of all globals is less than a given threshold (controllable via an option, cf. help("future.options")). 
If the threshold is exceeded, an informative error is thrown.
- Future expressions are only evaluated once. 
As soon as the value (or an error) has been collected it will be available for all succeeding requests.
-->

  - 式の評価は**ローカル環境**（すなわち `local({ 式 })`）で行われる。したがって、代入文は呼び出し環境に影響を与えない。
    これは評価が外部の R プロセスで行われるときはもちろん、現行の R セッションで行われるときにも適用される。
  - フューチャの作成時に、**グローバル変数が固定される**。 非同期評価の場合、グローバル変数は、フューチャの式を評価する R
    プロセスにエクスポートされる。 遅延評価 (`lazy = TRUE`)
    を伴う逐次戦略においては、グローバル変数はフリーズ（フューチャのローカル環境にクローン）される。
    また、誤って大きすぎるオブジェクトをエクスポートすることを防ぐために、グローバル変数の合計サイズにしきい値を設定できる。このしきい値を超えるとエラーが発生する（`help("future.options")`
    を参照）。
  - フューチャの式の評価は一度だけ実行される。 値が定まった（解決済み状態になった）あとで、同じフューチャをもう一度評価することはできない。

<!--
Here is an example illustrating that all assignments are done to a local environment:
-->

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

<!--
Now we are ready to explore the different future strategies.
-->

以上で、フューチャに共通するふるまいがわかった。 以降ではそれぞれのフューチャ戦略について見ていく。

### 同期的フューチャ

<!--
Synchronous futures are resolved one after another and most commonly by the R process that creates them. 
When a synchronous future is being resolved it blocks the main process until resolved. 
-->

同期的フューチャはフューチャを作成した R プロセスで一つひとつ解決される。
同期的フューチャが解決されている間、メインプロセスはブロックされる。


#### 逐次的フューチャ (Sequential Future)

<!--
Sequential futures are the default unless otherwise specified. 
They were designed to behave as similar as possible to regular R evaluation while still fulfilling the Future API and its behaviors.
Here is an example illustrating their properties:
-->

逐次的フューチャはデフォルトのフューチャである。 Future API の共通のふるまいを満たしながら、通常の R
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

<!--
Since eager sequential evaluation is taking place, each of the three futures is resolved instantaneously in the moment it is created. 
Note also how pid in the calling environment, which was assigned the process ID of the current process, is neither overwritten nor removed.
This is because futures are evaluated in a local environment. 
Since synchronous (uni-)processing is used, future b is resolved by the main R process (still in a local environment), which is why the value of b and pid are the same.
-->

逐次的な評価がその場で行われるため、3つのフューチャは作成と同時に即座に解決される。 呼び出し環境の `pid`（これは現行プロセスのプロセス
ID が代入されている）は上書きも削除もされないことに注意しよう。 これはフューチャがローカル環境で評価されるためである。
同期的な（単一の）プロセスが評価に使われるので、フューチャ `b` はメインの R
プロセスによって（ローカル環境で）解決される 。 これが `b` の値と `pid` が一致する理由である。


### 非同期的フューチャ

<!--
Next, we will turn to asynchronous futures, which are futures that are resolved in the background. 
By design, these futures are non-blocking, that is, after being created the calling process is available for other tasks including creating additional futures.
It is only when the calling process tries to access the value of a future that is not yet resolved, or trying to create another asynchronous future when all available R processes are busy serving other futures, that it blocks.
-->

非同期的フューチャの説明に移ろう。 非同期的フューチャは、バックグラウンドで処理されるフューチャである。
設計上、これらのフューチャはノンブロッキングである。
すなわち、フューチャを作成したとき、呼び出し側のプロセスは他のタスク（さらにフューチャを作るなど）に利用できる。
呼び出し側のプロセスがブロックされるのは、未解決のフューチャの値にアクセスを試みた場合か、すべての利用可能な R
プロセスが他のフューチャでビジーになっているときにさらに非同期のフューチャを作成しようとした場合に限られる。

#### マルチセッションフューチャ (Multisession Future)

<!--
We start with multisession futures because they are supported by all operating systems. 
A multisession future is evaluated in a background R session running on the same machine as the calling R process.
Here is our example with multisession evaluation:
-->

すべての OS で提供されているマルチセッションフューチャから始めよう。 マルチセッションフューチャは呼び出し側の R
プロセスと同じマシンで、バックグラウンドの R セッションにおいてフューチャを評価する。
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

<!--
The first thing we observe is that the values of a, c and pid are the same as previously. 
However, we notice that b is different from before.
This is because future b is evaluated in a different R process and therefore it returns a different process ID.
-->

この結果を見ると、`a`, `c`, `pid` の値は逐次的フューチャのときと同じであり、`b` だけが異なることがわかる。
その理由は、フューチャ `b` は現行とは別の R プロセスで評価され、そのプロセス ID
を返すからである。

<!--
When multisession evaluation is used, the package launches a set of R sessions in the background that will serve multisession futures by evaluating their expressions as they are created. 
If all background sessions are busy serving other futures, the creation of the next multisession future is blocked until a background session becomes available again. 
The total number of background processes launched is decided by the value of availableCores(), e.g.
-->

マルチセッション戦略を使うと、現行とは別の R セッションがバックグラウンドで起動され、フューチャは作成と同時にそれらの R
セッションで評価される。
もしすべてのバックグラウンドセッションが他のフューチャでビジーならば、新しく作成されたマルチセッションフューチャはバックグラウンドセッションが利用可能になるまで**ブロックされる**。
いくつのバックグラウンドプロセスが起動されるかは `availableCores()` の値によって決まる。

``` r
> availableCores()
mc.cores 
       2 
```

<!--
This particular result tells us that the mc.cores option was set such that we are allowed to use in total two (2) processes including the main process.
In other words, with these settings, there will be two (2) background processes serving the multisession futures. 
The availableCores() is also agile to different options and system environment variables.
For instance, if compute cluster schedulers are used (e.g. TORQUE/PBS and Slurm), they set specific environment variable specifying the number of cores that was allotted to any given job; availableCores() acknowledges these as well. 
If nothing else is specified, all available cores on the machine will be utilized, cf. parallel::detectCores(). 
For more details, please see help("availableCores", package = "parallelly").
-->

この結果から、メインプロセス以外に 2つのプロセスが利用可能なことがわかる。 したがって、この設定では、マルチセッションフューチャは
2つのバックグラウンドプロセスを使うことができる。 この値は `mc.cores` オプションで変更できる。
`availableCores()` はさまざまなオプションやシステム環境にも対応している。 例えば、計算クラスタスケジューラ（例えば
TORQUE/PBS や Slurm）を使用する場合、与えられたジョブに割り当てられたコア数を指定するための環境変数を設定する。 その場合も
`availableCores()` はそのコア数を認識する。 何も指定しない場合、マシン上の利用可能なすべてのコアが使われる。
このデフォルトの値は `parallel::detectCores()` で確認できる。 詳細については
`help("availableCores", package = "parallelly")` を参照してほしい。

#### マルチコアフューチャ (Multicore Future)

<!--
On operating systems where R supports forking of processes, which is basically all operating system except Windows, an alternative to spawning R sessions in the background is to fork the existing R process.
To use multicore futures, when supported, specify:
-->

R がプロセスの**フォーク (forking)** をサポートしている OS（基本的には Windows 以外）では、バックグラウンドで R
セッションを作成する代わりに、既存の R プロセスをフォークすることができる。
フォークがサポートされている場合、次のようにしてマルチコアフューチャを使用することができる。

``` r
plan(multicore)
```

<!--
Just like for multisession futures, the maximum number of parallel processes running will be decided by availableCores(), since in both cases the evaluation is done on the local machine.
-->

マルチセッションフューチャと同じように、並列に実行できるプロセスの最大値は `availableCores()` によって決まる。
どちらの場合も評価はローカルマシン上で行われる。

<!--
Forking an R process can be faster than working with a separate R session running in the background.
One reason is that the overhead of exporting large globals to the background session can be greater than when forking, and therefore shared memory, is used.
On the other hand, the shared memory is read only, meaning any modifications to shared objects by one of the forked processes (“workers”) will cause a copy by the operating system. 
This can also happen when the R garbage collector runs in one of the forked processes.
-->

フォークされた R プロセスでの実行は、バックグラウンド R セッションでの実行より速くなる。
その理由の1つは、フォークではメモリを共有するため、バックグラウンドセッションに大きなグローバル変数をエクスポートすることによるオーバーヘッドが無くなることにある。
一方、共有メモリは**読み取り専用**である。
つまり、フォークされたプロセス（ワーカ）が共有オブジェクトを変更しようとするとコピーを引き起こす。
これは、R のガベージコレクタが、フォークされたプロセスの1つで実行された場合にも生じる。

<!--
On the other hand, process forking is also considered unstable in some R environments.
For instance, when running R from within RStudio process forking may resulting in crashed R sessions. 
Because of this, the future package disables multicore futures by default when running from RStudio.
See help("supportsMulticore") for more details.
-->

また、プロセスのフォークは R 環境によっては不安定である。 例えば、RStudio のプロセス内から R
を実行しているときにフォークを行うと、 R
セッションがクラッシュする可能性がある。 このため、future
パッケージでは、RStudio 上でマルチコアフューチャの使用をデフォルトで無効にしている。 詳細は
`help("supportsMulticore")` を参照してほしい。

#### クラスタフューチャ (Cluster Future)

<!--
Cluster futures evaluate expressions on an ad-hoc cluster (as implemented by the parallel package). 
For instance, assume you have access to three nodes n1, n2 and n3, you can then use these for asynchronous evaluation as:
-->

クラスタフューチャは、（parallel パッケージで実装されているような）アドホッククラスタ上で式を評価する。 例えば、3つのクラスタノード
`n1`, `n2`, `n3` があるとき、それらを使って非同期処理を行うには次のようにする。

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

<!--
Any types of clusters that parallel::makeCluster() creates can be used for cluster futures. 
For instance, the above cluster can be explicitly set up as:
-->

`parallel::makeCluster()` で作られたクラスタなら何でもクラスタフューチャで利用できる。
例えば、上記のクラスタを明示的にセットアップするには次のように書く。

``` r
cl <- parallel::makeCluster(c("n1", "n2", "n3"))
plan(cluster, workers = cl)
```

<!--
Also, it is considered good style to shut down cluster cl when it is no longer needed, that is, calling parallel::stopCluster(cl). 
However, it will shut itself down if the main process is terminated. 
For more information on how to set up and manage such clusters, see help("makeCluster", package = "parallel"). 
Clusters created implicitly using plan(cluster, workers = hosts) where hosts is a character vector will also be shut down when the main R session terminates, or when the future strategy is changed, e.g. by calling plan(sequential).
-->

クラスタ `cl` がもう使われなくなったとき、`parallel::stopCluster(cl)`
を実行してクラスタをシャットダウンするのが良い作法である。
便利なことに、future パッケージは、メインプロセスが終了したときに、クラスタを自動でシャットダウンしてくれる。
クラスタのセットアップや管理については `help("makeCluster", package
= "parallel")` を参照してほしい。 `plan(cluster, workers = hosts)`（`hosts`
には文字列が入る）で非明示的に作られたクラスタも、メインの R セッションが終了するとシャットダウンされる。
また、フューチャ戦略が変更されたとき（例えば `plan(sequential)`
が呼ばれたとき）もクラスタはシャットダウンされる。

<!--
Note that with automatic authentication setup (e.g. SSH key pairs), there is nothing preventing us from using the same approach for using a cluster of remote machines.
-->

SSH キーペアなどの自動認証設定があるなら、リモートマシンのクラスタが同じ方法で使用できる。

<!--
If you want to run multiple workers on each node, just replicate the node name as many times as the number of workers to run on that node.
For example,
-->

各ノードで複数のワーカを実行したい場合は、次のようにノード名を複数回書けばよい。

```
> plan(cluster, workers = c(rep("n1", times = 3), "n2", rep("n3", times = 5)))
```

<!--
will run three workers on `n1`, one on `n2`, and five on `n3`, in total nine parallel workers.
-->

この例では、`n1` では3つ、`n2` では1つ、`n3` では5つと、合計9つのワーカにより並列実行される。


### フューチャのネストと評価トポロジー

<!--
This far we have discussed what can be referred to as “flat topology” of futures, that is, all futures are created in and assigned to the same environment. 
However, there is nothing stopping us from using a “nested topology” of futures, where one set of futures may, in turn, create another set of futures internally and so on.
-->

ここまでの説明では、フューチャは同じ環境で作成されていた。 これは「フラットトポロジー」と言うことができる。
しかし、フューチャの内部でフューチャを作成することもできる。
これを「ネストトポロジー」と呼ぶ。

<!--
For instance, here is an example of two “top” futures (a and b) that uses multisession evaluation and where the second future (b) in turn uses two internal futures:
-->

例えば、次の例では、2つの「トップ」フューチャ（`a` と `b`）があり、マルチセッション戦略を使って評価される。 ただし、フューチャ `b`
は内部に別のフューチャが使われている。

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

<!--
By inspection the process IDs, we see that there are in total three different processes involved for resolving the futures.
There is the main R process (pid 1427324), and there are the two processes used by a (pid 1427606) and b (pid 1427607). 
However, the two futures (b1 and b2) that is nested by b are evaluated by the same R process as b.
This is because nested futures use sequential evaluation unless otherwise specified. 
There are a few reasons for this, but the main reason is that it protects us from spawning off a large number of background processes by mistake, e.g. via recursive calls.
-->

プロセスIDを見ると、3つの異なるプロセスがフューチャの解決に使われていることがわかる。 メインプロセス (pid 1427324)、`a`
に使われるプロセス (pid 1427606)、`b` に使われるプロセス (pid 1427607) である。 しかし、`b`
にネストされている2つのフューチャ `b1` と `b2` は `b` と同じプロセスで評価されている。
これは、特に指定しない限り、ネストされたフューチャは逐次戦略を使って評価されるためである。
これにはいくつかの理由があるが、主な理由は、再帰呼び出しなどによって、誤って多くのバックグラウンドプロセスが発生するのを防ぐためである。

<!--
To specify a different type of evaluation topology, other than the first level of futures being resolved by multisession evaluation and the second level by sequential evaluation, we can provide a list of evaluation strategies to plan(). 
First, the same evaluation strategies as above can be explicitly specified as:
-->

`plan()` に戦略のリストを渡すことで、**評価トポロジー**を指定することができる。
例えば、上記と同じ評価トポロジーを明示的に指定するには次のようにする。

``` r
plan(list(multisession, sequential))
```

<!--
We would actually get the same behavior if we try with multiple levels of multisession evaluations;
-->

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

<!--
The reason for this is, also here, to protect us from launching more processes than what the machine can support. 
Internally, this is done by setting mc.cores = 1 such that functions like parallel::mclapply() will fall back to run sequentially. 
This is the case for both multisession and multicore evaluation.
-->

この理由は、ここでも、誤って多くのプロセスが起動するのを防ぐためである。 内部的には、`parallel::mclapply()`
のような関数が逐次実行されるように `mc.core = 1` が設定される。
これはマルチセッション評価とマルチコア評価の両方で起こる。

<!--
Continuing, if we start off by sequential evaluation and then use multisession evaluation for any nested futures, we get:
-->

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

<!--
which clearly show that a and b are resolved in the calling process (pid 1427324) whereas the two nested futures (b1 and b2) are resolved in two separate R processes (pids 1427855  and 1427854).
-->

`a` と `b` は呼び出しプロセス (pid 1427324) で解決され、ネストされた2つのフューチャ（`b1` と
`b2`）はそれぞれ別のプロセス (pid 1427855 と 1427854) で解決されることがわかる。

<!--
Having said this, it is indeed possible to use nested multisession evaluation strategies, if we explicitly specify (read force) the number of cores available at each level. 
In order to do this we need to “tweak” the default settings, which can be done as follows:
-->

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

<!--
First, we see that both a and b are resolved in different processes (pids 1427973 and 1427972) than the calling process (pid 1427324).
Second, the two nested futures (b1 and b2) are resolved in yet two other R processes (pids 1428098 and 1428099).
-->

まず、`a` と `b` は呼び出しプロセス (pid 1427324) とは異なるプロセス（pid 1427973 と 1427972）で解決される。
次に、2つのネストされたフューチャ（`b1` と `b2`）もまた異なるプロセス（pid 1428098 と 1428099）で解決される。

<!--
For more details on working with nested futures and different evaluation strategies at each level, see Vignette 'Futures in R: Future Topologies'.
-->

ネストされたフューチャの各レベルで異なる評価戦略を使う方法についての詳細は、ビネット [‘Futures in R: Future
Topologies’](https://cran.r-project.org/web/packages/future/vignettes/future-3-topologies.html)
を参照してほしい。

### ブロックされずにフューチャの状態を確認する

<!--
It is possible to check whether a future has been resolved or not without blocking. 
This can be done using the resolved(f) function, which takes an explicit future f as input.
If we work with implicit futures (as in all the examples above), we can use the f <- futureOf(a) function to retrieve the explicit future from an implicit one. 
For example,
-->

フューチャが解決済みか未解決かをブロックされずに確認する方法がある。 これには `resolved(f)` 関数を使う。
この関数には入力として明示的なフューチャ `f` を与える。
もし非明示的なフューチャを使っている場合、`f <-
futureOf(a)` のようにして非明示的なフューチャを明示的なフューチャに変換する必要がある。 例を次に示す。

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

<!--
Sometimes the future is not what you expected. 
If an error occurs while evaluating a future, the error is propagated and thrown as an error in the calling environment when the future value is requested. 
For example, if we use lazy evaluation on a future that generates an error, we might see something like
-->

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

<!--
The error is thrown each time the value is requested, that is, if we try to get the value again will generate the same error (and output):
-->

このエラーは値を要求するたびに起こる。 すなわち、もう一度値を取得しようとすると同じエラー（と出力）になる。

``` r
> a
Future 'a' ...
Error in log(b) : non-numeric argument to mathematical function
In addition: Warning message:
restarting interrupted promise evaluation
```

<!--
To see the last call in the call stack that gave the error, we can use the backtrace() function(*) on the future, i.e.
-->

エラーを起こしたコールスタックの**最後の**呼び出しを見るには、`backtrace()` 関数(\*)を使う。

``` r
> backtrace(a)
[[1]]
log(a)
```

<!--
(*) The commonly used traceback() does not provide relevant information in the context of futures.
Furthermore, it is unfortunately not possible to see the list of calls (evaluated expressions) that led up to the error; only the call that gave the error (this is due to a limitation in tryCatch() used internally).
-->

(\*) 一般的に使用される `traceback()` はフューチャの場合には関連情報を提供しない。
さらに、残念ながら、エラーの原因となった呼び出しのリストを見ることはできない。
エラーを起こした呼び出しだけを見ることができる（これは内部で使われる `tryCatch()` の制約である）。

## グローバルオブジェクト

<!--
Whenever an R expression is to be evaluated asynchronously (in parallel) or sequentially via lazy evaluation, global (aka “free”) objects have to be identified and passed to the evaluator.
They need to be passed exactly as they were at the time the future was created, because, for lazy evaluation, globals may otherwise change between when it is created and when it is resolved.
For asynchronous processing, the reason globals need to be identified is so that they can be exported to the process that evaluates the future.
-->

R
の式を非同期的に（並列に）評価するとき、または遅延評価で逐次評価するときは、グローバルオブジェクト（「フリー」オブジェクトとも言う）を特定して渡す必要がある。
遅延評価では、グローバルオブジェクトはフューチャの作成時と評価時で変更されている可能性があるため、フューチャの作成時とまったく同じ状態で渡す必要がある。
非同期評価では、フューチャを評価するプロセスにグローバルオブジェクトをエクスポートするために、それらを特定する必要がある。

<!--
The future package tries to automate these tasks as far as possible. 
It does this with help of the globals package, which uses static-code inspection to identify global variables. 
If a global variable is identified, it is captured and made available to the evaluating process.
Moreover, if a global is defined in a package, then that global is not exported. 
Instead, it is made sure that the corresponding package is attached when the future is evaluated.
This not only better reflects the setup of the main R session, but it also minimizes the need for exporting globals, which saves not only memory but also time and bandwidth, especially when using remote compute nodes.
-->

future パッケージではこれをできる限り自動化している。 そのために静的コード解析によってグローバル変数を特定する
[globals](https://cran.r-project.org/package=globals) パッケージが使われる。
グローバル変数が特定されると、キャプチャされ、評価プロセスで利用可能になる。
また、パッケージ内でグローバル変数が定義されている場合、それらはエクスポートされない。
かわりに、フューチャが評価されるときに対応するパッケージが確実に読み込まれているようにする。 これはメイン R
セッションの設定をよりよく反映するだけでなく、グローバルオブジェクトのエクスポートの必要性も最小限に抑える。
これにより、特にリモートの計算ノードを使用する場合、メモリだけでなく時間と帯域幅も節約できる。

<!--
Finally, it should be clarified that identifying globals from static code inspection alone is a challenging problem. 
There will always be corner cases where automatic identification of globals fails so that either false globals are identified (less of a concern) or some of the true globals are missing (which will result in a run-time error or possibly the wrong results). 
Vignette 'Futures in R: Common Issues with Solutions' provides examples of common cases and explains how to avoid them as well as how to help the package to identify globals or to ignore falsely identified globals.
If that does not suffice, it is always possible to manually specify the global variables by their names (e.g. globals = c("a", "slow_sum")) or as name-value pairs (e.g. globals = list(a = 42, slow_sum = my_sum)).
-->

最後に、静的コード解析だけではグローバル変数を特定するのは難しいということを述べておこう。
グローバル変数の自動識別に失敗するケースが常に存在する。
そのため、間違ってグローバル判定してしまう場合（これは特に問題にならない）と、グローバル変数を見逃してしまう場合（この場合はエラーか間違った結果になる）がある。
ビネット [‘Futures in R: Common Issues with
Solutions’](https://cran.r-project.org/web/packages/future/vignettes/future-4-issues.html)
では、そのようなケースの一般的な例や、避けるにはどうすればいいか、また、どのようにグローバル変数が特定されるかや間違って特定したグローバル変数を無視する方法を説明している。
それでも十分でない場合、グローバル変数の名前を指定する（例：`globals = c("a",
"slow_sum")`）か、名前と値のペアで指定する（例：`globals =
list(a = 42, slow_sum = my_sum)`）ことができる。

## 非明示的フューチャの制約

<!--
There is one limitation with implicit futures that does not exist for explicit ones.
Because an explicit future is just like any other object in R it can be assigned anywhere/to anything.
For instance, we can create several of them in a loop and assign them to a list, e.g.
-->

非明示的なフューチャには1つの制約がある。 明示的なフューチャは単なる R オブジェクトなので、どこでも何にでも代入可能である。
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

<!--
This is not possible to do when using implicit futures. 
This is because the %<-% assignment operator cannot be used in all cases where the regular <- assignment operator can be used. 
It can only be used to assign future values to environments (including the calling environment) much like how assign(name, value, envir) works. 
However, we can assign implicit futures to environments using named indices, e.g.
-->

これは非明示的なフューチャでは**できない**。 なぜなら、`%<-%` 演算子は通常の `<-` 代入演算子とは違う動作をするからである。
`%<-%` 演算子はフューチャの値を**環境**（呼び出し環境など）に代入する。 これは `assign(name, value,
envir)` と同じ動作である。
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

<!--
Here as.list(v) blocks until all futures in the environment v have been resolved.
Then their values are collected and returned as a regular list.
-->

ここで、`as.list(v)` は環境 `v` のすべてのフューチャが解決するまでブロックされる。
その後、フューチャの値は通常のリストとして返される。

<!--
If numeric indices are required, then list environments can be used. 
List environments, which are implemented by the listenv package, are regular environments with customized subsetting operators making it possible to index them much like how lists can be indexed.
By using list environments where we otherwise would use lists, we can also assign implicit futures to list-like objects using numeric indices. 
For example,
-->

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

<!--
As previously, as.list(v) blocks until all futures are resolved.
-->

ここでも、`as.list(v)` はすべてのフューチャが解決するまでブロックされる。

## デモ

<!--
To see a live illustration how different types of futures are evaluated, run the Mandelbrot demo of this package. 
First, try with the sequential evaluation,
-->

様々な戦略においてフューチャがどのように評価されるかの実例を見るには、このパッケージに含まれるマンデルブロ (Mandelbrot)
デモを実行するとよい。 まず、逐次評価で実行してみよう。

``` r
library(future)
plan(sequential)
demo("mandelbrot", package = "future", ask = FALSE)
```

<!--
which resembles how the script would run if futures were not used. 
Then, try multisession evaluation, which calculates the different Mandelbrot planes using parallel R processes running in the background. 
Try,
-->

これはフューチャを使用しない場合の動作とほとんど同じである。 次に、マルチセッション評価を試してみよう。
これは異なるマンデルブロ平面をバックグラウンドで実行される
R プロセスで並列に計算する。

``` r
plan(multisession)
demo("mandelbrot", package = "future", ask = FALSE)
```

<!--
Finally, if you have access to multiple machines you can try to set up a cluster of workers and use them, e.g.
-->

最後に、複数の計算機にアクセスできる場合、クラスタのワーカを指定して実行できる。

``` r
plan(cluster, workers = c("n2", "n5", "n6", "n6", "n9"))
demo("mandelbrot", package = "future", ask = FALSE)
```

## 貢献するには

<!--
The goal of this package is to provide a standardized and unified API for using futures in R. 
What you are seeing right now is an early but sincere attempt to achieve this goal. 
If you have comments or ideas on how to improve the 'future' package, I would love to hear about them.
The preferred way to get in touch is via the GitHub repository, where you also find the latest source code.
I am also open to contributions and collaborations of any kind.
-->

このパッケージの目的は、R でフューチャを使うための標準的で統一された API を提供することである。
現状はこの目的を達成するための初期段階にすぎない。
future パッケージを改善するアイデアや意見を持っている人がいたらぜひ教えてほしい。 開発者に連絡をとるには [GitHub
リポジトリ](https://github.com/futureverse/future/)経由が好ましいが、どのような手段であっても歓迎する。

## インストール

future パッケージは CRAN で利用可能であり、次のコードを実行してインストールできる。

``` r
install.packages("future")
```

### プレリリースバージョンのインストール

プレリリースバージョンは GitHub の `develop` ブランチにあり、インストールするには次のようにする。

``` r
remotes::install_github("futureverse/future", ref="develop")
```

これはソースからのインストールとなる。

<!-- pkgdown-drop-below -->

## 貢献

<!--
To contribute to this package, please see [CONTRIBUTING.md](CONTRIBUTING.md).
-->

このパッケージに貢献するには、[CONTRIBUTING.md](CONTRIBUTING.md) を参照してほしい。
