#!/bin/bash
encoder_='resASPP'
batch_=8
epoch_=100
dataset_='kitti'
data_path_='/xdisk/ditzler/mig2020/rsgrps/ditzler/kspeng/workspace/dataset/'

model_name="$(printf '%s_%s_%dx%d' ${dataset_%} ${encoder_%} ${batch_%} ${epoch_%})"
echo ">>> ${model_name}"

singularity run --nv /xdisk/ditzler/mig2020/rsgrps/ditzler/kspeng/envImg/tfcvpy36tf15.img \
monodepth_main.py --mode train \
--data_path "$(printf '%s%s/data/' ${data_path_%} ${dataset_%})" \
--filenames_file "$(printf 'utils/filenames/ua_train_files.txt' ${dataset_%})" \
--log_directory models/ \
--model_name ${model_name} \
--dataset ${dataset_} \
--encoder ${encoder_} \
--batch_size ${batch_} \
--num_epochs ${epoch_}

