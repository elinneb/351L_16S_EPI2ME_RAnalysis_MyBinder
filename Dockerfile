FROM rocker/binder:4.4.2

USER root

# Install packages used in the R Markdown lesson
RUN install2.r --error --skipinstalled \
    tidyverse \
    vegan \
    rmarkdown \
    knitr \
    BiocManager

# phyloseq is installed through Bioconductor
RUN R -q -e "BiocManager::install('phyloseq', ask = FALSE, update = FALSE)"

# Confirm that the essential packages installed successfully
RUN R -q -e "library(tidyverse); library(phyloseq); library(vegan)"

# Copy the lesson and datasets into the Binder workspace
COPY --chown=rstudio:rstudio . /home/rstudio

USER rstudio
WORKDIR /home/rstudio
