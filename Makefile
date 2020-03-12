run:
	Rscript -e "shiny::runApp()"

readme:
	Rscript -e "rmarkdown::render('README.Rmd', output_format = 'github_document')"
