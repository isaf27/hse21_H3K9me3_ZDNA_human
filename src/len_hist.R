setwd("/Users/isaf27/Documents/3rd_course/bio/project/hse21_H3K9me3_ZDNA_human/src")
source('lib.R')

###

#NAME <- 'DeepZ'
#NAME <- 'H3K9me3_A549.ENCFF444EWQ.hg19'
#NAME <- 'H3K9me3_A549.ENCFF444EWQ.hg38'
#NAME <- 'H3K9me3_A549.ENCFF811QUJ.hg19'
#NAME <- 'H3K9me3_A549.ENCFF811QUJ.hg38'
NAME <- 'H3K9me3_A549.intersect_with_DeepZ'

###

bed_df <- read.delim(paste0(DATA_DIR, NAME, '.bed'), as.is = TRUE, header = FALSE)
#colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.pdf'), path = OUT_DIR)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.png'), path = OUT_DIR)
