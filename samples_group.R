
###  calculate fold change

group_1 <- c( "GSM23735"  , "GSM23736"   , "GSM23737"  ,  "GSM23738"   , "GSM23740"   , "GSM23741"  ,  "GSM23742"  ,  "GSM23743"  ,  "GSM23744"   , "GSM23745"   , "GSM23746")
group_2 <- c("GSM23747"   , "GSM23753"   , "GSM23754"  ,  "GSM23755"   , "GSM23756"   , "GSM23757")
group_3 <- c("GSM23748" ,   "GSM23749" ,   "GSM23750"  ,  "GSM23751"   , "GSM23752" )

group_a <-apply(cdata[group_1],1,mean)
group_b <-apply(cdata[group_2],1,mean)
group_c <-apply(cdata[group_3],1,mean)
group_mean <- data.frame()
group_mean <- rbind(group_mean,group_a)
group_mean <- rbind(group_mean,group_b)
group_mean <- rbind(group_mean,group_c)
group_mean <- t(group_mean)
group_mean <- as.data.frame(group_mean)
names(group_mean)[1] <- "A"
names(group_mean)[2] <- "B"
names(group_mean)[3] <- "C"
row.names(group_mean) <- c(1:dim(group_mean)[1])
#group_data <- as.matrix(group_mean)
combs <- combn(colnames(group_mean),2)
print(combs)
log2_fun <- function(a,b) log((b-a)/a+1)
logfoldchange <- apply(combs,2,function(col_names) log2_fun(group_mean[,col_names[1]],group_mean[,col_names[2]]))
dimnames(logfoldchange)[2] <- list(apply(combs,2,paste,collapse='_'))
print(dim(logfoldchange))

gene_fold <- cbind(cdata[1],logfoldchange)
filename_1 <- strsplit(matrix_path,'_')[[1]][1]
filename_2 <- 'foldchange.txt'
filename <- paste(filename_1,filename_2,sep = '_')
write.table(gene_fold,filename,row.names=F, col.names=F, quote=F)  
