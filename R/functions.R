library("biomaRt")
#listMarts()
#ensembl=useMart("ensembl",dataset="hsapiens_gene_ensembl")
#listDatasets(ensembl)

human_entrez2ensembl<-function(){
  ensembl=useMart("ensembl",dataset="hsapiens_gene_ensembl")
  attrib = c("ensembl_gene_id","entrezgene")
  table<-getBM(attributes = attrib, mart = ensembl)
  return(table)
}

homolog_human2fly<-function(){
  ensembl=useMart("ensembl",dataset="hsapiens_gene_ensembl")
  attrib = c("ensembl_gene_id","dmelanogaster_homolog_ensembl_gene","dmelanogaster_homolog_orthology_type")
  table<-getBM(attributes = attrib, mart = ensembl)
  return(table)
}

fly_entrez2ensembl<-function(){
  ensembl=useMart("ensembl",dataset="dmelanogaster_gene_ensembl")
  attrib = c("ensembl_gene_id","entrezgene")
  table<-getBM(attributes = attrib, mart = ensembl)
  return(table)
}





