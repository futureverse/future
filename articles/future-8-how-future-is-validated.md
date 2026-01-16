# A Future for R: How the Future Framework is Validated

Since correctness and reproducibility is essential to all data
processing, validation is a top priority and part of the design and
implementation throughout the future ecosystem. Several types of testing
are performed.

First, all the essential core packages part of the future framework,
**[future](https://future.futureverse.org)**,
**[parallelly](https://parallelly.futureverse.org)**,
**[globals](https://globals.futureverse.org)**, and
**[listenv](https://listenv.futureverse.org)**, implement a rich set of
package tests. These are validated regularly across the wide-range of
operating systems (Linux, macOS, and MS Windows) and R versions
available on CRAN, on continuous integration (CI) services (GitHub
Actions), and on [R-hub](https://r-hub.github.io/rhub/). The core
packages are also tested with non-English locale settings, including
Korean, Simplified Chinese (China) and Traditional Chinese (Taiwan).
They are also verified to work with single-core and dual-core machines,
which may be the case for some free, cloud services that provide R.

Second, for each new release, these packages undergo full
reverse-package dependency checks using
**[revdepcheck](https://github.com/r-lib/revdepcheck)**. As of May 2025,
the **future** package is tested against ~450 direct reverse-package
dependencies available on CRAN and Bioconductor. These checks are
performed on Linux with both the default settings and when forcing tests
to use multisession workers (SOCK clusters), which further validates
that globals and packages are identified correctly. We also test with
`NOT_CRAN = true`, to further increase the test coverage.

Third, a suite of *Future API conformance tests* available in the
**[future.tests](https://future.tests.futureverse.org)** package
validates the correctness of all future backends. Any new future backend
developed must pass these tests to comply with the *Future API*. By
conforming to this API, the end-user can trust that the backend will
produce the same correct and reproducible results as any other backend,
including the ones that the developer has tested on. Also, by making it
the responsibility of the developer to assert that their new future
backend conforms to the *Future API*, we relieve other developers from
having to test that their future-based software works on all backends.
It would be a daunting task for a developer to validate the correctness
of their software with all existing backends. Even if they would achieve
that, there may be additional third-party future backends that they are
not aware of, that they do not have the possibility to test with, or
that yet have not been developed.

Fourth, since **[foreach](https://CRAN.R-Project.org/package=foreach)**
is used by a large number of essential CRAN packages, it provides an
excellent opportunity for supplementary validation. Specifically, we
dynamically tweak the examples of
**[foreach](https://CRAN.R-Project.org/package=foreach)** and popular
CRAN packages **[caret](https://CRAN.R-Project.org/package=caret)**,
**[glmnet](https://CRAN.R-Project.org/package=glmnet)**,
**[NMF](https://CRAN.R-Project.org/package=NMF)**,
**[plyr](https://CRAN.R-Project.org/package=plyr)**, and
**[TSP](https://CRAN.R-Project.org/package=TSP)** to use the
**[doFuture](https://doFuture.futureverse.org)** adaptor. This allows us
to run these examples with a variety of future backends to validate that
the examples produce no run-time errors, which indirectly validates the
backends as well as the *Future API*. In the past, these types of tests
helped to identify and resolve corner cases where automatic
identification of global variables would fail. As a side note, several
of these foreach-based examples fail when using a parallel foreach
adaptor because they do not properly export globals or declare package
dependencies. The exception is when using the sequential *doSEQ* adaptor
(default), fork-based ones such as
**[doMC](https://CRAN.R-Project.org/package=doMC)**, or the generic
**[doFuture](https://doFuture.futureverse.org)**, which supports any
future backend and relies on the future framework for handling globals
and packages(\*).

Lastly, analogously to above reverse-dependency checks of each new
release, CRAN and Bioconductor continuously run checks on all these
direct, but also indirect, reverse dependencies, which further increases
the validation of the *Future API* and the future ecosystem at large.

(\*) There is a plan to update
**[foreach](https://CRAN.R-Project.org/package=foreach)** to use the
exact same static-code-analysis method as the
**[future](https://future.futureverse.org)** package uses for
identifying globals. As the maintainer of the future framework, I
collaborate with the maintainer of the
**[foreach](https://CRAN.R-Project.org/package=foreach)** package to
implement this.
