#!/bin/bash
encoder_='vggASPP'
batch_=8
epoch_=100
alpha_image_loss_=0.85
disp_gradient_loss_weight_=0.5
dataset_='kitti'
data_path_='/groups/ditzler/'

model_name="$(printf '%s_%s_%dx%d' ${dataset_%} ${encoder_%} ${batch_%} ${epoch_%})"
loss_weights = "$(printf '\nAppearance: %g, Disparity smoothness: %g, Left-right consistency: %g\n' $1 $2 $3)"
echo ">>> ${model_name}"
echo "${loss_weights}"

singularity run --nv /groups/ditzler/envImg/tfcvpy36tf15.img \
monodepth_main.py --mode train \
--data_path "$(printf '%s%s/data/' ${data_path_%} ${dataset_%})" \
--filenames_file "$(printf 'utils/filenames/%s_train_files.txt' ${dataset_%})" \
--log_directory models/ \
--model_name ${model_name} \
--dataset ${dataset_} \
--encoder ${encoder_} \
--batch_size ${batch_} \
--num_epochs ${epoch_} \
--alpha_image_loss ${alpha_image_loss_} \
--appearance_loss_weight $1 \
--disp_gradient_loss_weight $2 \
--lr_loss_weight $3

