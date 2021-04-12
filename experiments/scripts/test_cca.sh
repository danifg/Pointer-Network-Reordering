
#COPY PRE-GENERATED CCAS
cp reordering/pregenerated_ccas/$2_test.cca.bracket reordering/input_parser/
cp reordering/pregenerated_ccas/$2_test.cca.pred reordering/predicted_cca/


#RUN YOUR OWN PARSER FOR TESTING
#FOR INSTANCE, FOR RUNNING A PREVIOUSLY-TRAINED Kitaev et al. (2019) PARSER
cd /home/personal/kitaev_parser/
python src/main.py test --test-path "/home/personal/Pointer-Network-Reordering/experiments/reordering/input_parser/ptb_test.cca.bracket" \
 --no-predict-tags --model-path models/English_bert_large_cased_*.pt \
    --output-path /home/personal/Pointer-Network-Reordering/experiments/reordering/output_parser/$1.bracket.predicted


#EVALUATE
cd /home/personal/Pointer-Network-Reordering/experiments/
./reordering/eval.sh $1 $2


