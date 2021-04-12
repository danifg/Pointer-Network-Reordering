
python reordering/bracket2discbracket.py reordering/predicted_cca/${2}_test.cca.pred < reordering/output_parser/${1}.bracket.predicted > reordering/disc_output_parser/${1}.discbracket.predicted

echo 'F1'
discodop eval reordering/data_discbracket/${2}_test.discbracket reordering/disc_output_parser/${1}.discbracket.predicted  reordering/proper.prm --fmt=discbracket  | tail -n 13

echo 'DiscF1'
discodop eval reordering/data_discbracket/${2}_test.discbracket reordering/disc_output_parser/${1}.discbracket.predicted  reordering/proper.prm --fmt=discbracket --disconly  | tail -n 13 
