# -*- coding: utf-8 -*-
"""
Created on Sat Jun 22 16:23:11 2019

@author: xiaob
"""
import linecache

# extract the gene symbol
def extract_gene_symbol(gene_path):
    file =open(gene_path,'r',encoding='UTF-8')
    file_gene = file.readlines()
    
    w1 = '!platform_table_begin'
    w2 = '!sample_table_end'
    gene_symbol =[]
    for (num,line) in enumerate(file_gene):
        temp1 = line.strip('\n')
        temp2 = temp1.split('\t')
        temp2 = ''.join(temp2)
        if temp2[0:21] == w1:
            key1_num = num       
        if temp2[0:17] == w2:
            key2_num = num
            
    for linenum in range(key1_num+2,key2_num+1):
    #    print(linenum)
        linecont = linecache.getline(gene_path,linenum)
        linecont =linecont[:-1]
        gene_symbol.append(linecont) 
#    gene_name = np.matrix(gene_symbol)   
    return gene_symbol


gene_path = "GSE1428_family.soft"
data = extract_gene_symbol(gene_path)
print(data)      