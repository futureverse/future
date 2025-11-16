# A condition (message, warning, or error) that occurred while orchestrating a future

While *orchestrating* (creating, launching, querying, collection)
futures, unexpected run-time errors (and other types of conditions) may
occur. Such conditions are coerced to a corresponding FutureCondition
class to help distinguish them from conditions that occur due to the
*evaluation* of the future.

## Usage

``` r
FutureCondition(message, call = NULL, uuid = future[["uuid"]], future = NULL)

FutureMessage(message, call = NULL, uuid = future[["uuid"]], future = NULL)

FutureWarning(message, call = NULL, uuid = future[["uuid"]], future = NULL)

FutureError(message, call = NULL, uuid = future[["uuid"]], future = NULL)

RngFutureCondition(
  message = NULL,
  call = NULL,
  uuid = future[["uuid"]],
  future = NULL
)

RngFutureWarning(...)

RngFutureError(...)

UnexpectedFutureResultError(future, hint = NULL)

GlobalEnvMisuseFutureCondition(
  message = NULL,
  call = NULL,
  differences = NULL,
  uuid = future[["uuid"]],
  future = NULL
)

GlobalEnvMisuseFutureWarning(...)

GlobalEnvMisuseFutureError(...)

ConnectionMisuseFutureCondition(
  message = NULL,
  call = NULL,
  differences = NULL,
  uuid = future[["uuid"]],
  future = NULL
)

ConnectionMisuseFutureWarning(...)

ConnectionMisuseFutureError(...)

DeviceMisuseFutureCondition(
  message = NULL,
  call = NULL,
  differences = NULL,
  uuid = future[["uuid"]],
  future = NULL
)

DeviceMisuseFutureWarning(...)

DeviceMisuseFutureError(...)

DefaultDeviceMisuseFutureCondition(
  message = NULL,
  incidents = NULL,
  call = NULL,
  uuid = future[["uuid"]],
  future = NULL
)

DefaultDeviceMisuseFutureWarning(...)

DefaultDeviceMisuseFutureError(...)

FutureLaunchError(..., future = NULL)

FutureInterruptError(..., future = NULL)

FutureCanceledError(..., future = NULL)

FutureDroppedError(..., future = NULL)

FutureJournalCondition(
  message,
  journal,
  call = NULL,
  uuid = future[["uuid"]],
  future = NULL
)
```

## Arguments

- message:

  A message condition.

- call:

  The call stack that led up to the condition.

- uuid:

  A universally unique identifier for the future associated with this
  FutureCondition.

- future:

  The [Future](https://future.futureverse.org/reference/Future-class.md)
  involved.

- hint:

  (optional) A string with a suggestion on what might be wrong.

## Value

An object of class FutureCondition which inherits from class
[condition](https://rdrr.io/r/base/conditions.html) and FutureMessage,
FutureWarning, and FutureError all inherits from FutureCondition.
Moreover, a FutureError inherits from
[error](https://rdrr.io/r/base/conditions.html), a FutureWarning from
[warning](https://rdrr.io/r/base/conditions.html), and a FutureMessage
from [message](https://rdrr.io/r/base/conditions.html).
