#!/bin/bash
#SBATCH --job-name=ufet_clusters
#SBATCH --partition=gpu_p2
#SBATCH --qos=qos_gpu-t4
#SBATCH --output=cl_%j.out
#SBATCH --error=cl_%j.err
#SBATCH --time=99:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:4
#SBATCH --cpus-per-task=8
#SBATCH --hint=nomultithread
#SBATCH --mail-user=bouraoui@cril.fr
#SBATCH -A rag@gpu

cd $SCRATCH/ufet
module purge
module load pytorch-gpu/py3/1.5.1
module load gcc/8.3.1
module load cuda/10.2
module load nccl/2.6.4-1-cuda
module load cudnn/7.6.5.32-cuda-10.2
module load intel-mkl/2020.1
module load magma/2.5.3-cuda
module load openmpi/4.0.2-cuda

source activate py36

srun python ./src/domain_model/main.py -multitask -tune_all -do_train -optim_th -model_id bert_base_cased_mcrae_cslb_debv3l_0.5thresh_filter_cnetp_chatgpt100k_bert_large_con_50simprop_clustered_file -d_goal ce_cluster -dfn_postfix mcrae_cslb_debv3l_0.5thresh_filter_cnetp_chatgpt100k_bert_large_con_50simprop_clustered_file -dfc_param ufet_domain_types_from_clusters\cross_entopy_bert_large\cnetp_vocab\bert_base_cased_dfc_mcrae_cslb_debv3l_0.5thresh_filter_cnetp_chatgpt100k_bert_large_con_50simprop_clustered_file.pt