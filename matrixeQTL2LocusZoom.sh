#!/bin/bash

#Select entries with ENSEMBL gene name from input file
grep $1 $3 > $1.eQTL.input

#Format input eQTL file
tr -d "\"" < $1.eQTL.input > $1.eQTL.input.noquote
tail -n+2 $1.eQTL.input.noquote > $1.eQTL.input.noquote.noheader
cut -f1,4 $1.eQTL.input.noquote.noheader > $1.eQTL.input.noquote.noheader.cut
sed 's/6\://g' $1.eQTL.input.noquote.noheader.cut > $1.eQTL.input.noquote.noheader.cut.sed

#Remove temp files
rm $1.eQTL.input
rm $1.eQTL.input.noquote
rm $1.eQTL.input.noquote.noheader
rm $1.eQTL.input.noquote.noheader.cut

#Grep chr from dbSNP142 
grep "chr$2" snp142.cut_tab > snp142.cut_tab.chr$2
grep -v "chr$2_" snp142.cut_tab.chr$2 >snp142.cut_tab.chr$2_clean

#Create output
awk -F " " 'BEGIN{while(getline<"$1.eQTL.input.noquote.noheader.cut.sed") a[$1]=1&&b[$1]=$2 } ; a[$3] ==1 {print $4, b[$3] } ' snp142.cut_tab.chr$2_clean >$1.eQTL.input.noquote.noheader.cut.sed.rsid

#Remove temp file
rm $1.eQTL.input.noquote.noheader.cut.sed
