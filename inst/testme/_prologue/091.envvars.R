## Comment: The below should be set automatically whenever the future package
## is loaded and 'R CMD check' runs.  The below is added in case R is changed
## in the future and we fail to detect 'R CMD check'.
Sys.setenv(R_PARALLELLY_MAKENODEPSOCK_CONNECTTIMEOUT = 2 * 60)
Sys.setenv(R_PARALLELLY_MAKENODEPSOCK_TIMEOUT = 2 * 60)
Sys.setenv(R_PARALLELLY_MAKENODEPSOCK_SESSIONINFO_PKGS = TRUE)
Sys.setenv(R_FUTURE_WAIT_INTERVAL = 0.01) ## 0.01s (instead of default 0.2s)

## Label PSOCK cluster workers (to help troubleshooting)
test_script <- grep("[.]R$", commandArgs(), value = TRUE)[1]
if (is.na(test_script)) test_script <- "UNKNOWN"
worker_label <- sprintf("future/tests/%s:%s:%s:%s", test_script, Sys.info()[["nodename"]], Sys.info()[["user"]], Sys.getpid())
Sys.setenv(R_PARALLELLY_MAKENODEPSOCK_RSCRIPT_LABEL = worker_label)

## Reset the following during testing in case
## they are set on the test system
oenvs2 <- Sys.unsetenv(c(
  "R_PARALLELLY_AVAILABLECORES_SYSTEM",
  "R_PARALLELLY_AVAILABLECORES_FALLBACK",
  ## SGE
  "NSLOTS", "PE_HOSTFILE",
  ## Slurm
  "SLURM_CPUS_PER_TASK",
  ## TORQUE / PBS
  "NCPUS", "PBS_NUM_PPN", "PBS_NODEFILE", "PBS_NP", "PBS_NUM_NODES"
))
