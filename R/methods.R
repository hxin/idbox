
find_one2one_orthologs_Human2Fly<-function(ids){
  h2f<-human2fly()
  h2f_one2one<-h2f[h2f$dmelanogaster_homolog_orthology_type=='ortholog_one2one',]
}


.is.entrez<-function(id=123456){
  if(grepl("^[[:digit:]]",id,perl=T))
    return(TRUE)
  else
    return(FALSE)
}