### Forest Plots


```r
Long_sk_Res <- gather(NCAtable, key = "Parameter", value = "Value", -Subject)
MyForeNCA<- lapply(unique(Long_sk_Res$Parameter), function(x)
    foreNCA(NCAtable, PPTESTCD = x, PCTESTCD = ""))
```

```
## Error in `[.data.frame`(NCAres, , "PCTESTCD"): undefined columns selected
```


