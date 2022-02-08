#!/bin/bash

cd ~/EVE
export PATH=~/miniconda3/bin:$PATH
source ~/miniconda3/bin/activate protein_env
# conda activate protein_env

echo $(which python3)
pwd

gpuprof=$(dcgmi group -c mygpus -a $SGE_GPU | awk '{print $10}')
dcgmi stats -g $gpuprof -e
dcgmi stats -g $gpuprof -s $JOB_ID

export MSA_data_folder='./data/MSA'
export MSA_list='./data/mappings/P53_mapping.csv'
export MSA_weights_location='./data/weights'
export VAE_checkpoint_location='./results/VAE_parameters'
export model_name_suffix='P53'
export model_parameters_location='./EVE/default_model_params.json'
export training_logs_location='./logs/'
export protein_index=0

python train_VAE.py \
    --MSA_data_folder ${MSA_data_folder} \
    --MSA_list ${MSA_list} \
    --protein_index ${protein_index} \
    --MSA_weights_location ${MSA_weights_location} \
    --VAE_checkpoint_location ${VAE_checkpoint_location} \
    --model_name_suffix ${model_name_suffix} \
    --model_parameters_location ${model_parameters_location} \
    --training_logs_location ${training_logs_location} 

dcgmi stats -g $gpuprof -x $JOB_ID
dcgmi stats -g $gpuprof -v -j $JOB_ID
dcgmi group -d $gpuprof


