#!/bin/bash
#Select entries with ENSEMBL gene name from input file
grep $1 $3 > $1.eQTL.input

tr -d "\"" < $1.eQTL.input > $1.eQTL.input.noquote
tail -n+2 $1.eQTL.input.noquote > $1.eQTL.input.noquote.noheader
cut -f1,4 $1.eQTL.input.noquote.noheader > $1.eQTL.input.noquote.noheader.cut
sed 's/6\://g' $1.eQTL.input.noquote.noheader.cut > $1.eQTL.input.noquote.noheader.cut.sed

rm $1.eQTL.input
rm $1.eQTL.input.noquote
rm $1.eQTL.input.noquote.noheader
rm $1.eQTL.input.noquote.noheader.cut

grep "chr$2" snp142.cut_tab > snp142.cut_tab.chr$2
grep -v "chr$2_" snp142.cut_tab.chr$2 >snp142.cut_tab.chr$2_clean
awk -F " " 'BEGIN{while(getline<"$1.eQTL.input.noquote.noheader.cut.sed") a[$1]=1&&b[$1]=$2 } ; a[$3] ==1 {print $4, b[$3] } ' snp142.cut_tab.chr$2_clean >$1.eQTL.input.noquote.noheader.cut.sed.rsid

rm $1.eQTL.input.noquote.noheader.cut.sed
