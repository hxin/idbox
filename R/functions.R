#library("biomaRt")
#listMarts()
#ensembl=useMart("ensembl",dataset="hsapiens_gene_ensembl")
#listDatasets(ensembl)

human_entrez2ensembl<-function(...){
  entrez2ensembl(species='hsapiens',...)
}

fly_entrez2ensembl<-function(...){
  entrez2ensembl(species="dmelanogaster",...)
}

homolog_human2fly<-function(...){
  homolog(x='hsapiens',y='dmelanogaster',...)
}



human2fly<-function(){
  f_e2e<-fly_entrez2ensembl()
  names(f_e2e)<-paste("fly_",names(f_e2e),sep='')
  h_e2e<-human_entrez2ensembl()
  names(h_e2e)<-paste("human_",names(h_e2e),sep='')
  h2f<-homolog_human2fly()
  
  table<-merge(h2f,h_e2e,by.x='ensembl_gene_id',by.y='human_ensembl_gene_id')
  table<-merge(table,f_e2e,by.x='dmelanogaster_homolog_ensembl_gene',by.y='fly_ensembl_gene_id')
  return(table)
}


####listDatasets(useMart("ensembl"))
entrez2ensembl<-function(species='hsapiens',na.rm=TRUE){
  ensembl=useMart("ensembl",dataset=paste(species,'_gene_ensembl',sep=''))
  attrib = c("ensembl_gene_id","entrezgene")
  table<-getBM(attributes = attrib, mart = ensembl)
  
  ##remove na
  if(na.rm)
    table<-table[complete.cases(table),]
  
  return(table)
}

##as<-listAttributes(useMart("ensembl"))
##as[grep('dmelanogaster',x=as$name,ignore.case=T),]
homolog<-function(x='hsapiens',y='dmelanogaster',rm.na=TRUE){
  ensembl=useMart("ensembl",dataset=paste(x,'_gene_ensembl',sep=''))
  homolog_gene<-paste(y,"_homolog_ensembl_gene",sep='')
  orthology_type<-paste(y,"_homolog_orthology_type",sep='')
  attrib = c("ensembl_gene_id",homolog_gene,orthology_type)
  table<-getBM(attributes = attrib, mart = ensembl)
  
  ##remove na
  if(rm.na){
    table<-table[complete.cases(table),]
    ##na here are empty string instead of 'NA'
    table<-table[table[,homolog_gene]!="",]
  }
    
  return(table)
}


listDs<-function(){
  listDatasets(useMart("ensembl"))
}

.find.in.attr.list.by.name<-function(key='',dataset='hsapiens_gene_ensembl'){
  as<-listAttributes(useMart("ensembl",dataset=dataset))
    as[grep(key,x=as$name,ignore.case=T),]
}
.find.in.attr.list.by.description<-function(key='',dataset='hsapiens_gene_ensembl'){
  as<-listAttributes(useMart("ensembl",dataset=dataset))
  as[grep(key,x=as$description,ignore.case=T),]
}

.name.dictionary<-function(){
  l<-list(human=list(slug="human",species="hsapiens",dataset="hsapiens_gene_ensembl"))
  l<-list(l,list(fly=list(slug="fly",species="dmelanogaster",dataset="dmelanogaster_gene_ensembl")))
  return(l)
}

