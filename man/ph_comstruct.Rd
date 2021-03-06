% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/comstruct.R
\name{ph_comstruct}
\alias{ph_comstruct}
\title{comstruct}
\usage{
ph_comstruct(sample, phylo, null_model = 0, randomizations = 999,
  swaps = 1000, abundance = TRUE)
}
\arguments{
\item{sample}{(data.frame/character) sample data.frame or path to a
sample file}

\item{phylo}{(character/phylo) One of: phylogeny as a newick string (will be
written to a temp file) - OR path to file with a newick
string - OR a an \pkg{ape} `phylo` object. required.}

\item{null_model}{(integer) which null model to use. See Details.}

\item{randomizations}{(numeric) number of randomizations. Default: 999}

\item{swaps}{(numeric) number of swaps. Default: 1000}

\item{abundance}{(logical) If \code{TRUE} (default) computed accounting
for abundance. Otherwise, uses presence-absence.}
}
\value{
data.frame
}
\description{
Calculates mean phylogenetic distance (MPD) and mean nearest
phylogenetic taxon distance (MNTD; aka MNND) for each sample, and
compares them to MPD/MNTD values for randomly generated samples
(null communities) or phylogenies.
}
\section{Null models}{

\itemize{
 \item 0 - Phylogeny shuffle: This null model shuffles species labels across
 the entire phylogeny. This randomizes phylogenetic relationships among
 species.
 \item 1 - Species in each sample become random draws from sample pool:
 This null model maintains the species richness of each sample, but the
 identities of the species occurring in each sample are randomized. For
 each sample, species are drawn without replacement from the list of all
 species actually occurring in at least one sample. Thus, species in the
 phylogeny that are not actually observed to occur in a sample will not
 be included in the null communities
 \item 2 - Species in each sample become random draws from phylogeny pool:
 This null model maintains the species richness of each sample, but the
 identities of the species occurring in each sample are randomized. For
 each sample, species are drawn without replacement from the list of all
 species in the phylogeny pool. All species in the phylogeny will have
 equal probability of being included in the null communities. By changing
 the phylogeny, different species pools can be simulated. For example, the
 phylogeny could include the species present in some larger region.
 \item 3 - Independent swap: The independent swap algorithm (Gotelli and
 Entsminger, 2003); also known as ‘SIM9’ (Gotelli, 2000) creates swapped
 versions of the sample/species matrix.
}
}

\examples{
sfile <- system.file("examples/sample_comstruct", package = "phylocomr")
pfile <- system.file("examples/phylo_comstruct", package = "phylocomr")

# from data.frame
sampledf <- read.table(sfile, header = FALSE,
  stringsAsFactors = FALSE)
phylo_str <- readLines(pfile)
(res <- ph_comstruct(sample = sampledf, phylo = phylo_str))

# from files
sample_str <- paste0(readLines(sfile), collapse = "\\n")
sfile2 <- tempfile()
cat(sample_str, file = sfile2, sep = '\\n')
pfile2 <- tempfile()
cat(phylo_str, file = pfile2, sep = '\\n')
(res <- ph_comstruct(sample = sfile2, phylo = pfile2))

# different null models
ph_comstruct(sample = sfile2, phylo = pfile2, null_model = 0)
ph_comstruct(sample = sfile2, phylo = pfile2, null_model = 1)
ph_comstruct(sample = sfile2, phylo = pfile2, null_model = 2)
# ph_comstruct(sample = sfile2, phylo = pfile2, null_model = 3)
}
