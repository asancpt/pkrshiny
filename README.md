

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
- We are actively developing R pacakges, Shiny Apps, and Edison Science Apps regarding clinical pharmacology and pharmacometrics. Please check here. <https://asancpt.github.io/softwares>

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

<p>Chang W, Cheng J, Allaire J, Xie Y, McPherson J (2020).
<em>shiny: Web Application Framework for R</em>.
R package version 1.4.0.1, <a href="https://CRAN.R-project.org/package=shiny">https://CRAN.R-project.org/package=shiny</a>. 
</p>
<p>Bae K, Lee JE (2018).
<em>pkr: Pharmacokinetics in R</em>.
R package version 0.1.2, <a href="https://CRAN.R-project.org/package=pkr">https://CRAN.R-project.org/package=pkr</a>. 
</p>
<p>Allaire J, Horner J, Xie Y, Marti V, Porte N (2019).
<em>markdown: Render Markdown with the C Library 'Sundown'</em>.
R package version 1.1, <a href="https://CRAN.R-project.org/package=markdown">https://CRAN.R-project.org/package=markdown</a>. 
</p>
<p>Grosjean P, Ibanez F (2018).
<em>pastecs: Package for Analysis of Space-Time Ecological Series</em>.
R package version 1.3.21, <a href="https://CRAN.R-project.org/package=pastecs">https://CRAN.R-project.org/package=pastecs</a>. 
</p>
<p>Wickham H (2016).
<em>ggplot2: Elegant Graphics for Data Analysis</em>.
Springer-Verlag New York.
ISBN 978-3-319-24277-4, <a href="https://ggplot2.tidyverse.org">https://ggplot2.tidyverse.org</a>. 
</p>
<p>Wickham H, François R, Henry L, Müller K (2020).
<em>dplyr: A Grammar of Data Manipulation</em>.
https://dplyr.tidyverse.org, https://github.com/tidyverse/dplyr. 
</p>
<p>Wickham H, Henry L (2020).
<em>tidyr: Tidy Messy Data</em>.
R package version 1.0.2, <a href="https://CRAN.R-project.org/package=tidyr">https://CRAN.R-project.org/package=tidyr</a>. 
</p>
<p>Gohel D, Skintzos P (2019).
<em>ggiraph: Make 'ggplot2' Graphics Interactive</em>.
R package version 0.7.0, <a href="https://CRAN.R-project.org/package=ggiraph">https://CRAN.R-project.org/package=ggiraph</a>. 
</p>
<p>Chang W, Borges Ribeiro B (2018).
<em>shinydashboard: Create Dashboards with 'Shiny'</em>.
R package version 0.7.1, <a href="https://CRAN.R-project.org/package=shinydashboard">https://CRAN.R-project.org/package=shinydashboard</a>. 
</p>
<p>Xie Y (2020).
<em>knitr: A General-Purpose Package for Dynamic Report Generation in R</em>.
R package version 1.28, <a href="https://yihui.org/knitr/">https://yihui.org/knitr/</a>. 
</p>

<p>Xie Y (2015).
<em>Dynamic Documents with R and knitr</em>, 2nd edition.
Chapman and Hall/CRC, Boca Raton, Florida.
ISBN 978-1498716963, <a href="https://yihui.org/knitr/">https://yihui.org/knitr/</a>. 
</p>

<p>Xie Y (2014).
&ldquo;knitr: A Comprehensive Tool for Reproducible Research in R.&rdquo;
In Stodden V, Leisch F, Peng RD (eds.), <em>Implementing Reproducible Computational Research</em>.
Chapman and Hall/CRC.
ISBN 978-1466561595, <a href="http://www.crcpress.com/product/isbn/9781466561595">http://www.crcpress.com/product/isbn/9781466561595</a>. 
</p>

### Session information


```
## ─ Session info ───────────────────────────────────────────────────────────────
##  setting  value                       
##  version  R version 3.6.3 (2020-02-29)
##  os       Ubuntu 18.04.4 LTS          
##  system   x86_64, linux-gnu           
##  ui       X11                         
##  language (EN)                        
##  collate  C.UTF-8                     
##  ctype    C.UTF-8                     
##  tz       Etc/UTC                     
##  date     2020-03-12                  
## 
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package        * version     date       lib source                            
##  assertthat       0.2.1       2019-03-21 [2] CRAN (R 3.6.3)                    
##  backports        1.1.5       2019-10-02 [2] CRAN (R 3.6.3)                    
##  binr           * 1.1         2015-03-10 [1] CRAN (R 3.6.3)                    
##  boot             1.3-24      2019-12-20 [4] CRAN (R 3.6.2)                    
##  callr            3.4.2       2020-02-12 [2] CRAN (R 3.6.3)                    
##  checkmate      * 2.0.0       2020-02-06 [2] CRAN (R 3.6.3)                    
##  cli              2.0.2       2020-02-28 [2] CRAN (R 3.6.3)                    
##  colorspace       1.4-1       2019-03-18 [2] CRAN (R 3.6.3)                    
##  crayon           1.3.4       2017-09-16 [2] CRAN (R 3.6.3)                    
##  desc             1.2.0       2018-05-01 [2] CRAN (R 3.6.3)                    
##  devtools         2.2.2       2020-02-17 [1] CRAN (R 3.6.3)                    
##  digest           0.6.25      2020-02-23 [2] CRAN (R 3.6.3)                    
##  dplyr          * 0.8.99.9000 2020-03-08 [1] Github (tidyverse/dplyr@5e7682b)  
##  ellipsis         0.3.0       2019-09-20 [2] CRAN (R 3.6.3)                    
##  evaluate         0.14        2019-05-28 [2] CRAN (R 3.6.3)                    
##  fansi            0.4.1       2020-01-08 [2] CRAN (R 3.6.3)                    
##  farver           2.0.3       2020-01-16 [2] CRAN (R 3.6.3)                    
##  fastmap          1.0.1       2019-10-08 [2] CRAN (R 3.6.3)                    
##  foreign        * 0.8-76      2020-03-03 [4] CRAN (R 3.6.3)                    
##  forestplot     * 1.9         2019-06-24 [1] CRAN (R 3.6.3)                    
##  fs               1.3.2       2020-03-05 [2] CRAN (R 3.6.3)                    
##  gdtools        * 0.2.1       2019-10-14 [1] CRAN (R 3.6.3)                    
##  ggiraph        * 0.7.0       2019-10-31 [1] CRAN (R 3.6.3)                    
##  ggplot2        * 3.3.0.9000  2020-03-11 [1] Github (tidyverse/ggplot2@86c6ec1)
##  glue             1.3.1       2019-03-12 [2] CRAN (R 3.6.3)                    
##  gtable           0.3.0       2019-03-25 [2] CRAN (R 3.6.3)                    
##  highr            0.8         2019-03-20 [2] CRAN (R 3.6.3)                    
##  htmltools        0.4.0       2019-10-04 [2] CRAN (R 3.6.3)                    
##  htmlwidgets      1.5.1       2019-10-08 [2] CRAN (R 3.6.3)                    
##  httpuv           1.5.2       2019-09-11 [2] CRAN (R 3.6.3)                    
##  jsonlite         1.6.1       2020-02-02 [2] CRAN (R 3.6.3)                    
##  knitr          * 1.28        2020-02-06 [2] CRAN (R 3.6.3)                    
##  labeling         0.3         2014-08-23 [2] CRAN (R 3.6.3)                    
##  later            1.0.0       2019-10-04 [2] CRAN (R 3.6.3)                    
##  lifecycle        0.2.0       2020-03-06 [2] CRAN (R 3.6.3)                    
##  magrittr       * 1.5         2014-11-22 [2] CRAN (R 3.6.3)                    
##  markdown       * 1.1         2019-08-07 [2] CRAN (R 3.6.3)                    
##  memoise          1.1.0       2017-04-21 [2] CRAN (R 3.6.3)                    
##  mime             0.9         2020-02-04 [2] CRAN (R 3.6.3)                    
##  munsell          0.5.0       2018-06-12 [2] CRAN (R 3.6.3)                    
##  pastecs        * 1.3.21      2018-03-15 [1] CRAN (R 3.6.3)                    
##  pillar           1.4.3       2019-12-20 [2] CRAN (R 3.6.3)                    
##  pkgbuild         1.0.6       2019-10-09 [2] CRAN (R 3.6.3)                    
##  pkgconfig        2.0.3       2019-09-22 [2] CRAN (R 3.6.3)                    
##  pkgload          1.0.2       2018-10-29 [2] CRAN (R 3.6.3)                    
##  pkr            * 0.1.2       2018-06-04 [1] CRAN (R 3.6.3)                    
##  prettyunits      1.1.1       2020-01-24 [2] CRAN (R 3.6.3)                    
##  processx         3.4.2       2020-02-09 [2] CRAN (R 3.6.3)                    
##  promises         1.1.0       2019-10-04 [2] CRAN (R 3.6.3)                    
##  ps               1.3.2       2020-02-13 [2] CRAN (R 3.6.3)                    
##  purrr            0.3.3       2019-10-18 [2] CRAN (R 3.6.3)                    
##  R.methodsS3      1.8.0       2020-02-14 [2] CRAN (R 3.6.3)                    
##  R.oo             1.23.0      2019-11-03 [2] CRAN (R 3.6.3)                    
##  R6               2.4.1       2019-11-12 [2] CRAN (R 3.6.3)                    
##  Rcpp             1.0.3       2019-11-08 [2] CRAN (R 3.6.3)                    
##  remotes          2.1.1       2020-02-15 [1] CRAN (R 3.6.3)                    
##  rlang            0.4.5       2020-03-01 [2] CRAN (R 3.6.3)                    
##  rprojroot        1.3-2       2018-01-03 [2] CRAN (R 3.6.3)                    
##  rtf            * 0.4-14      2019-05-27 [2] CRAN (R 3.6.3)                    
##  scales           1.1.0       2019-11-18 [2] CRAN (R 3.6.3)                    
##  sessioninfo      1.1.1       2018-11-05 [1] CRAN (R 3.6.3)                    
##  shiny          * 1.4.0.1     2020-03-12 [2] CRAN (R 3.6.3)                    
##  shinydashboard * 0.7.1       2018-10-17 [1] CRAN (R 3.6.3)                    
##  stringi          1.4.6       2020-02-17 [2] CRAN (R 3.6.3)                    
##  stringr          1.4.0       2019-02-10 [2] CRAN (R 3.6.3)                    
##  systemfonts      0.1.1       2019-07-01 [1] CRAN (R 3.6.3)                    
##  testthat         2.3.2       2020-03-02 [2] CRAN (R 3.6.3)                    
##  tibble           2.1.3       2019-06-06 [2] CRAN (R 3.6.3)                    
##  tidyr          * 1.0.2       2020-01-24 [2] CRAN (R 3.6.3)                    
##  tidyselect       1.0.0       2020-01-27 [2] CRAN (R 3.6.3)                    
##  usethis          1.5.1       2019-07-04 [1] CRAN (R 3.6.3)                    
##  uuid             0.1-4       2020-02-26 [1] CRAN (R 3.6.3)                    
##  vctrs            0.2.99.9010 2020-03-11 [1] Github (r-lib/vctrs@63b2712)      
##  withr            2.1.2       2018-03-15 [2] CRAN (R 3.6.3)                    
##  xfun             0.12        2020-01-13 [2] CRAN (R 3.6.3)                    
##  xml2             1.2.5       2020-03-11 [2] CRAN (R 3.6.3)                    
##  xtable           1.8-4       2019-04-21 [2] CRAN (R 3.6.3)                    
##  yaml             2.2.1       2020-02-01 [2] CRAN (R 3.6.3)                    
## 
## [1] /home/ubuntu/R/x86_64-pc-linux-gnu-library/3.6
## [2] /usr/local/lib/R/site-library
## [3] /usr/lib/R/site-library
## [4] /usr/lib/R/library
```

