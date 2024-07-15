#!/bin/bash
#SBATCH --job-name=llm_eval
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-node=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=logs/%j.%x.info.log
#SBATCH --error=logs/%j.%x.error.log

srun lm_eval --model hf --model_args pretrained=mistralai/Mistral-7B-v0.1,peft=$1,dtype="bfloat16" --tasks $2 --batch_size auto