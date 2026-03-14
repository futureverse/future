SHELL=bash

update-problems: revdep/problems.md
	if ! grep -q "* CRAN: " "$<"; then \
	    sed -i -E 's|^\* GitHub mirror: <https://github.com/cran/(.*)>|* GitHub mirror: <https://github.com/cran/\1>\n* CRAN: <https://cran.r-project.org/package=\1>\n* CRAN checks: <https://cran.r-project.org/web/checks/check_results_\1.html>|' "$<"; \
	fi
