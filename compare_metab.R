#Run the script with the associated metabolite file. 
#Rscript compare_metab.R MetabTable_ForComparison.csv Results_features.txt

args<-commandArgs(TRUE)
data<-read.table(args[1],sep=",",row.names=1,header=TRUE)

metab_pos<-grep("X",names(data))

results_data<-as.data.frame(matrix(NA,length(metab_pos),12))

for(i in 1:length(metab_pos)){
results_data[i,1:4]<-boxplot(data[,metab_pos[i]]~data$ATTRIBUTE_treatment,plot=FALSE)$stats[3,]
results_data[i,5]<-kruskal.test(data[,metab_pos[i]]~data$ATTRIBUTE_treatment)$p.value
results_data[i,6]<-names(data)[metab_pos[i]]
temp<-pairwise.wilcox.test(data[,metab_pos[i]],data$ATTRIBUTE_treatment,p.adjust="bonf")
results_data[i,7:9]<-temp$p.value[1:3,1]
results_data[i,10:11]<-temp$p.value[2:3,2]
results_data[i,12]<-temp$p.value[3,3]
}

names(results_data)<-c(levels(data$ATTRIBUTE_treatment),"pval","Feature","Benznidazole-Carnitine","Benznidazole-Untreated","Benznidazole-Vehicle","Carnitine-Untreated","Carnitine-Vehicle","Untreated-Vehicle")

results_data$fdr<-p.adjust(results_data$pval,method="fdr")

write.table(results_data,file=args[2],sep="\t",quote=FALSE,row.names=FALSE)
