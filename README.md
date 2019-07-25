# MR-blastx
aa database and SRA hits


#to run blastx on a cluster (anthill) do: 

cat IDS.txt | xargs -I{} sh -c "mkdir bX_{}" 

cat IDS.txt | xargs -I{} sh -c "mv {}_good_out.fasta bX_{}/" 

cat IDS.txt | xargs -I{} sh -c "cp split_blast_queries_edwards_blastplus.pl bX_{}"

cat IDS.txt | xargs -I{} sh -c "cd bX_{}; perl split_blast_queries_edwards_blastplus.pl -f {}_good_out.fasta -n 100 -p blastx -db /home3/acobian/Marisa/DB/Bacteroides-cellulosilyticus-WH2 -N {} -evalue 0.001 -outfmt '6 qseqid sseqid pident length length qstart qend sstart send evalue bitscore'"
