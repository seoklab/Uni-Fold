#!/bin/bash

fasta_path=$1
symmetry=$2
output_dir_base=$3
database_dir=$4
max_template_date=$5
param_path=$6

echo "Starting homogeneous searching..."
unifold-homo-search \
    --fasta_path=$fasta_path \
    --max_template_date=$max_template_date \
    --output_dir=$output_dir_base  \
    --uniref90_database_path=$database_dir/uniref90/uniref90.fasta \
    --mgnify_database_path=$database_dir/mgnify/mgy_clusters_2018_12.fa \
    --bfd_database_path=$database_dir/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt \
    --uniclust30_database_path=$database_dir/uniclust30/uniclust30_2018_08/uniclust30_2018_08 \
    --uniprot_database_path=$database_dir/uniprot/uniprot.fasta \
    --pdb_seqres_database_path=$database_dir/pdb_seqres/pdb_seqres.txt \
    --template_mmcif_dir=$database_dir/pdb_mmcif/mmcif_files \
    --obsolete_pdbs_path=$database_dir/pdb_mmcif/obsolete.dat \
    --use_precomputed_msas=True

echo "Starting prediction..."
fasta_file=$(basename $fasta_path)
target_name=${fasta_file%.fa*}
unifold-inference-symmetry \
	--symmetry=$symmetry \
	--param_path=$param_path \
	--data_dir=$output_dir_base \
	--target_name=$target_name \
	--output_dir=$output_dir_base
