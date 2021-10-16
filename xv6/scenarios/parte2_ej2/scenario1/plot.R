######### Ejecucion #########

#> $ Rscript plot.R

######### Packages  #########
packages <- c("readxl", "tseries", "dynlm", "mFilter", "ggplot2", "dplyr")
sapply(packages, require, character.only = TRUE)

######### bases #########

cpubench <- read.table("cpubench.txt", quote="\"", comment.char="")

cpubench_2iobench <- read.table("cpubench_2iobench.txt", quote="\"", comment.char="")

cpubench2 <- read.table("2cpubench.txt", quote="\"", comment.char="")

cpubench2_2iobench <- read.table("2cpubench_2iobench.txt", quote="\"", comment.char="")

iobench <- read.table("iobench.txt", quote="\"", comment.char="")

iobench_2cpubench <- read.table("iobench_2cpubench.txt", quote="\"", comment.char="")

iobench_cpubench <- read.table("iobench_cpubench.txt", quote="\"", comment.char="")

iobench2 <- read.table("2iobench.txt", quote="\"", comment.char="")

######### plot y .png #########

png(file = "plot_part2_2_esc1.png")
bind_rows(cpubench = cpubench, cpubench_2iobench = cpubench_2iobench,
          cpubench2 = cpubench2, cpubench2_2iobench = cpubench2_2iobench,
          iobench = iobench, iobench_2cpubench = iobench_2cpubench,
          iobench_cpubench = iobench_cpubench, iobench2 = iobench2,
          .id = "id") %>%
    ggplot(mapping = aes(x = V3)) +
        geom_bar(width=0.5, fill='lightblue') +
        facet_wrap(~id) +
        theme(panel.grid = element_blank()) +
        labs(title = "Escenario 1: quantum 10 veces más corto y tick de 2500", y = "Número de Operaciones (promedio)", x= "") 
dev.off()
