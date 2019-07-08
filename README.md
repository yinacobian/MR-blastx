# MR-blastx
aa database and SRA hits

/home3/acobian/Marisa/V2
ERR313104_good_out.fasta

perl split_blast_queries_edwards_blastplus.pl -f ERR313104_good_out.fasta -n 10 -p blastx -db /home3/acobian/Marisa/DB/Bacteroides_CIS_proteins -N ERR313104 -evalue 0.001 -outfmt '6 qseqid sseqid pident length length qstart qend sstart send evalue bitscore'

"perl split_blast_queries_edwards_blastplus.pl -f {}_good_out.fasta -n 10 -p blastx -db /home3/acobian/Marisa/DB/Bacteroides_CIS_proteins -N {} -evalue 0.001 -outfmt '6 qseqid sseqid pident length length qstart qend sstart send evalue bitscore'"

cat SRAID.txt | xargs -I{} sh -c "perl split_blast_queries_edwards_blastplus.pl -f {}_good_out.fasta -n 100 -p blastx -db /home3/acobian/Marisa/DB/Bacteroides_CIS_proteins -N {} -evalue 0.001 -outfmt '6 qseqid sseqid pident length length qstart qend sstart send evalue bitscore'"

