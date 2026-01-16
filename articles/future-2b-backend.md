# A Future for R: Available Future Backends

The **future** package comes with built-in future backends that leverage
parallel frameworks available in the **parallel** package, which is part
of R itself. In addition to these backends, others exist in package
extensions,
e.g. **[future.callr](https://future.callr.futureverse.org)**,
**[future.mirai](https://future.mirai.futureverse.org)**, and
**[future.batchtools](https://future.batchtools.futureverse.org)**.
Below is an overview of the most common backends that you as an end-user
can choose from.

[TABLE]

📶: futures relay progress updates in real-time,
e.g. **[progressr](https://progressr.futureverse.org)**  
♻️: futures are interruptible and restartable; \* interrupts are
disabled by default  
(next): next release; (soon): in a near-future release
