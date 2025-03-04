{ pkgs, ... }:
pkgs.rstudioWrapper.override {
  packages = with pkgs.rPackages; [
    ggplot2
    dplyr
    xts
    dslabs
    data_table
    tidyr
    ggrepel
    hexbin
    patchwork
    pheatmap
    GGally
    mclust
    fossil
    cowplot
    ROCR
    plotROC
    rpart
    rpart_plot
    caret
    randomForest
    png
  ];
}
