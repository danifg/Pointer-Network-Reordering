
cp models/$1/tmp/gold.txt   output_pointer/$1_test.cca.GOLD
cp models/$1/tmp/pred.txt   output_pointer/$1_test.cca.pred


paste reordering/output_pointer/$1_test.cca.pred  reordering/$2-GOLD-WORDS > reordering/tmp2
cat reordering/tmp2 | awk  '{print $1 "\t" $9 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' > reordering/tmp3 


python reordering/conll_to_cca_brackets.py reordering/tmp3 > reordering/input_parser/$2_test.cca.bracket
python reordering/conll_to_cca.py reordering/tmp3 > reordering/predicted_cca/$2_test.cca.pred


rm reordering/tmp2
rm reordering/tmp3
