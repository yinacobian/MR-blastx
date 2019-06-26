#make blastX database
#cd /home3/acobian/Marisa/DB
#makeblastdb -in Bacteroides_CIS_proteins.fna -input_type fasta -dbtype prot -out Bacteroides_CIS_proteins

#IDS:
#SRR029167
#SRR029168
#SRR029169
#SRR029170
#SRR029171
#SRR029172
#SRR029173
#SRR029704
#SRR029705
#SRR029706
#SRR029707

#to tun: bash marisa_blastx.sh IDS.txt

#get fastq files from the SRA
#fastq-dump --outdir /home3/acobian/Marisa --gzip --skip-technical --readids --dumpbase --split-files --clip SRR029167
cat $1 | xargs -I{fileID} sh -c 'fastq-dump --outdir /home3/acobian/Marisa --gzip --skip-technical --readids --dumpbase --split-files --clip {fileID}'

#remove reads with N's and convert to fasta
#prinseq++ -fastq SRR029167_1.fastq.gz -out_format 1 -ns_max_n 1 
cat $1 | xargs -I{fileID} sh -c 'prinseq++ -fastq {fileID}_1.fastq.gz -out_format 1 -ns_max_n 1 -out_name {fileID}'

#blastX 
#blastx -db /home3/acobian/Marisa/DB/Bacteroides_CIS_proteins -query {fileID}_good_out.fasta -out example_vs_{fileID}_good_out.blastx -num_threads 20 -evalue 0.001 -outfmt '6 qseqid sseqid pident length length qstart qend sstart send evalue bitscore'
cat $1 | xargs -I{fileID} sh -c "blastx -db /home3/acobian/Marisa/DB/Bacteroides_CIS_proteins -query {fileID}_good_out.fasta -out Bacteroides_CIS_proteins_vs_{fileID}_good_out.blastx -num_threads 20 -evalue 0.001 -outfmt '6 qseqid sseqid pident length length qstart qend sstart send evalue bitscore'"

#Get besthit from blastx output
#perl /home3/acobian/bin/besthitblast.pl example_vs_TFYfkY_good_out.blastx > besthit_example_vs_TFYfkY_good_out.blastx
cat $1 | xargs -I{fileID} sh -c 'perl /home3/acobian/bin/besthitblast.pl Bacteroides_CIS_proteins_vs_{fileID}_good_out.blastx > besthit_Bacteroides_CIS_proteins_vs_{fileID}_good_out.blastx'

#Count hits per database entry 
cat $1 | xargs -I{fileID} sh -c 'cut -f 2 besthit_Bacteroides_CIS_proteins_vs_{fileID}_good_out.blastx | sort | uniq -c | sort -nr  | sed -e "s/^ *//" | tr " " "\t" > hits_Bacteroides_CIS_proteins_vs_{fileID}_good_out.tab'

#Get size of metagenomes and create tj.txt file
#cat IDS.txt | xargs -I{fileID} sh -c "echo {fileID}; grep '>' {fileID}_good_out.fasta | wc -l"

#Merge and get hits


#Merge and normalyze





