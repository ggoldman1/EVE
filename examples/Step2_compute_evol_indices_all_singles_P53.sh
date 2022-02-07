#!/bin/bash

cd ~/EVE
echo $PATH
export PATH=~/miniconda3/bin:$PATH
echo $PATH
source activate protein_env 

echo $(which python3)

#gpuprof=$(dcgmi group -c mygpus -a $SGE_GPU | awk '{print $10}')
#dcgmi stats -g $gpuprof -e
#dcgmi stats -g $gpuprof -s $JOB_ID

export MSA_data_folder='./data/MSA'
export MSA_list='./data/mappings/P53_mapping.csv'
export MSA_weights_location='./data/weights'
export VAE_checkpoint_location='./results/VAE_parameters'
export model_name_suffix='P53'
export model_parameters_location='./EVE/default_model_params.json'
export training_logs_location='./logs/'
export protein_index=0

export computation_mode='all_singles'
export all_singles_mutations_folder='./data/mutations'
export output_evol_indices_location='./results/evol_indices'
export num_samples_compute_evol_indices=20000
export batch_size=2048

python -i compute_evol_indices.py \
    --MSA_data_folder ${MSA_data_folder} \
    --MSA_list ${MSA_list} \
    --protein_index ${protein_index} \
    --MSA_weights_location ${MSA_weights_location} \
    --VAE_checkpoint_location ${VAE_checkpoint_location} \
    --model_name_suffix ${model_name_suffix} \
    --model_parameters_location ${model_parameters_location} \
    --computation_mode ${computation_mode} \
    --all_singles_mutations_folder ${all_singles_mutations_folder} \
    --output_evol_indices_location ${output_evol_indices_location} \
    --num_samples_compute_evol_indices ${num_samples_compute_evol_indices} \
    --batch_size ${batch_size}

#dcgmi stats -g $gpuprof -x $JOB_ID
#dcgmi stats -g $gpuprof -v -j $JOB_ID
#dcgmi group -d $gpuprof

