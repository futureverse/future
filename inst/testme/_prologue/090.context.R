fullTest <- (Sys.getenv("_R_CHECK_FULL_") != "")

covr_testing <- ("covr" %in% loadedNamespaces())
on_macos <- grepl("^darwin", R.version$os)
on_githubactions <- as.logical(Sys.getenv("GITHUB_ACTIONS", "FALSE"))
