######### Ejecucion #########

#> $ Rscript plot.R

######### Packages  #########
packages <- c("readxl", "tseries", "dynlm", "mFilter", "ggplot2", "dplyr")
sapply(packages, require, character.only = TRUE)

######### bases #########

cpubench <- read.table("cpubench.txt", quote="\"", comment.char="")
c0 <- mean(cpubench[,2])

cpubench_2iobench <- read.table("cpubench_2iobench.txt", quote="\"", comment.char="")
c1 <- filter(cpubench_2iobench, V3 == "KFLOPT")
c1 <- mean(c1[,2])

i1 <- filter(cpubench_2iobench, V3 == "IOP2500T")
i1 <- mean(i1[,2])
i1 

cpubench2 <- read.table("2cpubench.txt", quote="\"", comment.char="")
c2 <- mean(cpubench2[,2])

cpubench2_2iobench <- read.table("2cpubench_2iobench.txt", quote="\"", comment.char="")
c3 <- filter(cpubench2_2iobench, V3 == "KFLOPT")
c3 <- mean(c3[,2])

i3 <- filter(cpubench2_2iobench, V3 == "IOP2500T")
i3 <- mean(i3[,2])

iobench <- read.table("iobench.txt", quote="\"", comment.char="")
i4 <- filter(iobench, V3 == "IOP2500T")
i4 <- mean(i4[,2])

iobench_2cpubench <- read.table("iobench_2cpubench.txt", quote="\"", comment.char="")
c5 <- filter(iobench_2cpubench, V3 == "KFLOPT")
c5 <- mean(c5[,2])

i5 <- filter(iobench_2cpubench, V3 == "IOP2500T")
i5 <- mean(i5[,2])

iobench_cpubench <- read.table("iobench_cpubench.txt", quote="\"", comment.char="")
c6 <- filter(iobench_cpubench, V3 == "KFLOPT")
c6 <- mean(c6[,2])

i6 <- filter(iobench_cpubench, V3 == "IOP2500T")
i6 <- mean(i6[,2])

iobench2 <- read.table("2iobench.txt", quote="\"", comment.char="")
i7 <- filter(iobench2, V3 == "IOP2500T")
i7 <- mean(i7[,2])

escenarios <- c("cpubench(c0)", "cpubench_2iobench(c1)","cpubench_2iobench(i1)", "cpubench2(c2)", "cpubench2_2iobench(c3)",
                "cpubench2_2iobench(i3)", "iobench(4)", "iobench_2cpubench(c5)", "iobench_2cpubench(i5)",
                "iobench_cpubench(c6)", "iobench_cpubench(i6)", "cpubench2")
promedios <- c(c(c0), c(c1,i1), c(c2), c(c3,i3), c(i4), c(c5,i5), c(c6,i6), c(i7))

table <- data.frame(escenarios, promedios)
table

######### plot y .png #########

png(file = "plot_part4_es2.png")
bind_rows("cpubench" = cpubench, "cpubench y 2 iobench" = cpubench_2iobench,
          "2 cpubench" = cpubench2, "2 cpubench y 2 iobench" = cpubench2_2iobench,
          "iobench" = iobench, "iobench y 2 cpubench" = iobench_2cpubench,
          "iobench y cpubench" = iobench_cpubench, "2 iobench" = iobench2,
          .id = "id") %>%
    ggplot(mapping = aes(x = V3)) +
        geom_bar(width=0.5, fill='lightblue') +
        facet_wrap(~id) +
        theme(panel.grid = element_blank()) +
        labs(title = "Comparación de escenarios (Parte 4, escenario 2)", y = "Número accesos", x= "Tipo de programa") 
dev.off()
