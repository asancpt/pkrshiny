

## pkr Shiny 

<div align="center">
  <a href="https://opensource.org/licenses/mit-license.php">
    <img alt="MIT Licence" src="https://badges.frapsoft.com/os/mit/mit.svg?v=103" />
  </a>
  <a href="https://github.com/ellerbrock/open-source-badge/">
    <img alt="Open Source Love" src="https://badges.frapsoft.com/os/v1/open-source.svg?v=103" />
  </a>
</div>

- `pkr Shiny` <https://asan.shinyapps.io/pkrshiny>
- `pkr Shiny` is open to everyone. We are happy to take your input. Please fork the repo, modify the codes and submit a pull request. <https://github.com/asancpt/pkrshiny>
- We are actively developing R pacakges, Shiny Apps, and Edison Science Apps regarding clinical pharmacology and pharmacometrics. Please check here. <https://asancpt.github.io>

### Installation of pkr R Package

```r
install.packages("pkr")
library(pkr)
NCA(Theoph, "Subject", "Time", "conc", dose=320, uConc="mg/L")
```

### Help

- `pkr` package help <https://cran.r-project.org/web/packages/pkr/pkr.pdf>

### Dataset

- `Theoph`: Oral 320 mg (N=12) <http://stat.ethz.ch/R-manual/R-devel/library/datasets/html/Theoph.html>
- `Indometh`: IV 25 mg (N=6) <http://stat.ethz.ch/R-manual/R-devel/library/datasets/html/Indometh.html>
- `sd_oral_richpk`: Oral 5000mg (N=50) <https://github.com/dpastoor/PKPDdatasets>
- `sd_iv_rich_pkpd`: IV diverse dosing (N=60) <https://github.com/dpastoor/PKPDdatasets>

### CDISC materials

- [CDISC SDTM Implementation Guide 3.2 PDF ](https://www.cdisc.org/sites/default/files/members/standard/foundational/sdtmig/sdtmig_20v3.2_20noportfolio.pdf)
- [CDISC Terminology PDF](https://evs.nci.nih.gov/ftp1/CDISC/SDTM/SDTM%20Terminology.pdf)

### References

Gabrielsson J, Weiner D. Pharmacokinetic and Pharmacodynamic Data Analysis - Concepts and Applications. 5th ed. 2016.

Shargel L, Yu A. Applied Biopharmaceutics and Pharmacokinetics. 7th ed. 2015.

Rowland M, Tozer TN. Clinical Pharmacokinetics and Pharmacodynamics - Concepts and Applications. 4th ed. 2011.

Gibaldi M, Perrier D. Pharmacokinetics. 2nd ed. revised and expanded. 1982.

### Bibliography of R packages

<p>Chang W, Cheng J, Allaire J, Xie Y and McPherson J (2017).
<em>shiny: Web Application Framework for R</em>.
R package version 1.0.0, <a href="https://CRAN.R-project.org/package=shiny">https://CRAN.R-project.org/package=shiny</a>. 
</p>
<p>Bae K and Lee JE (2017).
<em>pkr: Pharmacokinetics in R</em>.
R package version 0.1.0, <a href="https://CRAN.R-project.org/package=pkr">https://CRAN.R-project.org/package=pkr</a>. 
</p>
<p>Allaire J, Horner J, Marti V and Porte N (2015).
<em>markdown: 'Markdown' Rendering for R</em>.
R package version 0.7.7, <a href="https://CRAN.R-project.org/package=markdown">https://CRAN.R-project.org/package=markdown</a>. 
</p>
<p>Grosjean P and Ibanez F (2014).
<em>pastecs: Package for Analysis of Space-Time Ecological Series</em>.
R package version 1.3-18, <a href="https://CRAN.R-project.org/package=pastecs">https://CRAN.R-project.org/package=pastecs</a>. 
</p>
<p>Wickham H (2009).
<em>ggplot2: Elegant Graphics for Data Analysis</em>.
Springer-Verlag New York.
ISBN 978-0-387-98140-6, <a href="http://ggplot2.org">http://ggplot2.org</a>. 
</p>
<p>Wickham H and Francois R (2016).
<em>dplyr: A Grammar of Data Manipulation</em>.
R package version 0.5.0, <a href="https://CRAN.R-project.org/package=dplyr">https://CRAN.R-project.org/package=dplyr</a>. 
</p>
<p>Wickham H (2017).
<em>tidyr: Easily Tidy Data with 'spread()' and 'gather()' Functions</em>.
R package version 0.6.1, <a href="https://CRAN.R-project.org/package=tidyr">https://CRAN.R-project.org/package=tidyr</a>. 
</p>
<p>Gohel D (????).
<em>ggiraph: Make 'ggplot2' Graphics Interactive</em>.
R package version 0.3.2, <a href="https://davidgohel.github.io/ggiraph">https://davidgohel.github.io/ggiraph</a>. 
</p>
<p>Chang W (2016).
<em>shinydashboard: Create Dashboards with 'Shiny'</em>.
R package version 0.5.3, <a href="https://CRAN.R-project.org/package=shinydashboard">https://CRAN.R-project.org/package=shinydashboard</a>. 
</p>
<p>Xie Y (2016).
<em>knitr: A General-Purpose Package for Dynamic Report Generation in R</em>.
R package version 1.15.1, <a href="http://yihui.name/knitr/">http://yihui.name/knitr/</a>. 
</p>

<p>Xie Y (2015).
<em>Dynamic Documents with R and knitr</em>, 2nd edition.
Chapman and Hall/CRC, Boca Raton, Florida.
ISBN 978-1498716963, <a href="http://yihui.name/knitr/">http://yihui.name/knitr/</a>. 
</p>

<p>Xie Y (2014).
&ldquo;knitr: A Comprehensive Tool for Reproducible Research in R.&rdquo;
In Stodden V, Leisch F and Peng RD (eds.), <em>Implementing Reproducible Computational Research</em>.
Chapman and Hall/CRC.
ISBN 978-1466561595, <a href="http://www.crcpress.com/product/isbn/9781466561595">http://www.crcpress.com/product/isbn/9781466561595</a>. 
</p>
