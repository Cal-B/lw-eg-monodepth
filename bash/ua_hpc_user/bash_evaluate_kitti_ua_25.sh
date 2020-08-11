#!/bin/bash
encoder_='vggASPP'
batch_=8
epoch_=100
dataset_='4'
split_='kitti'
ckpt_=362500
lr_loss_=0.25

data_path_='/home/u22/cpbarrett/lw-eg-monodepth/dashcam_frames/'

model_name="$(printf '%s_%s_%dx%d_Ccor_25' "kitti" ${encoder_%} ${batch_%} ${epoch_%})"
echo ">>> ${model_name}"

singularity run --nv /groups/ditzler/envImg/tfcvpy36tf15.img \
monodepth_main.py --mode test \
--data_path "$(printf '%s%s/' ${data_path_%} ${dataset_%})" \
--filenames_file utils/filenames/filenames4.txt \
--log_directory ../log/ \
--encoder ${encoder_} \
--checkpoint_path $(printf 'models/%s/model-%d' ${model_name%} ${ckpt_%})

# echo ">>> ${backbone%}"
# echo ">>> Kitti: Native Evaluation"
# singularity run --nv /groups/ditzler/envImg/tfcvpy36tf15.img \
# utils/evaluate_kitti.py --split ${split_} \
# --gt_path "$(printf '%s%s/stereo2015/' '/groups/ditzler/' 'kitti')" \
# --predicted_disp_path $(printf 'models/%s/disparities.npy' ${model_name%})

# echo ">>> Kitti: Post-Processing Evaluation"
# singularity run --nv /groups/ditzler/envImg/tfcvpy36tf15.img \
# utils/evaluate_kitti.py --split ${split_} \
# --gt_path "$(printf '%s%s/stereo2015/' '/groups/ditzler/' 'kitti')" \
# --predicted_disp_path $(printf 'models/%s/disparities_pp.npy' ${model_name%})

# echo ">>> Kitti: Edge-Guided Post-Processing Evaluation"
# singularity run --nv /groups/ditzler/envImg/tfcvpy36tf15.img \
# utils/evaluate_kitti.py --split ${split_} \
# --gt_path "$(printf '%s%s/stereo2015/' '/groups/ditzler/' 'kitti')" \
# --predicted_disp_path $(printf 'models/%s/disparities_ppp.npy' ${model_name%})

