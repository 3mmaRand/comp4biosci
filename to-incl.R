# dunb test with specif comparisons

culture <- read_csv("data-raw/culture.csv")

kruskal.test(data = culture, diameter ~ medium)
## 
##  Kruskal-Wallis rank sum test
## 
## data:  diameter by medium
## Kruskal-Wallis chi-squared = 8.1005, df = 2, p-value = 0.01742

library(FSA)

dunn_results<- dunnTest(data = culture, diameter ~ medium)
##                                  Comparison          Z    P.unadj      P.adj
## 1                     control - sugar added -0.2159242 0.82904681 0.82904681
## 2     control - sugar and amino acids added -2.5656880 0.01029714 0.03089142
## 3 sugar added - sugar and amino acids added -2.3497637 0.01878533 0.03757066

# where the unadjust p values are
dunn_results$res$P.unadj

# get unadjust pvalues only for the first and second comparison
comparisons <- dunn_results$res$P.unadj[c(1,2)]
p.adjust(comparisons, method = "holm")
