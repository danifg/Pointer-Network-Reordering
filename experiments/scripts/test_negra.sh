#!/usr/bin/env bash
LOGPATH=$1 

CUDA_VISIBLE_DEVICES=0 OMP_NUM_THREADS=4 python -u pointer.py --mode parse --config configs/parsing/l2r_de.json --num_epochs 600 --batch_size 256 \
 --opt adam --learning_rate 0.001 --lr_decay 0.999997 --beta1 0.9 --beta2 0.9 --eps 1e-4 --grad_clip 5.0 \
 --loss_type token --warmup_steps 40 --reset 20 --weight_decay 0.0 --unk_replace 0.5 --beam 10 \
 --word_embedding sskip --word_path "embs/sskip.de.gz" --char_embedding random \
 --train "reordering/input_pointer/negra_train.cca.conllx" \
 --dev "reordering/input_pointer/negra_dev.cca.conllx" \
 --test "reordering/input_pointer/negra_test.cca.conllx" \
 --model_path "models/"$1 \
--bert --bert_dim 1024 \
--bert_path_test "embs/negra.test.bertlarge.cased" 
