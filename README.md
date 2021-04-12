
# Pointer Network Reordering
This repository includes a Pointer Network for reordering sentences according to a continuous canonical arrangement (CCA) defined by DISCODOP, allowing the discontinuous-to-continuous conversion described in [Reducing Discontinuous to Continuous Parsing with Pointer Network Reordering](https://arxiv.org/abs/). This is mainly based on the framework by Ma et al. (2018) (https://github.com/XuezheMax/NeuroNLP2). 


## Requirements
This implementation was tested with Python 3.6.12, PyTorch 1.7.1, NLTK 3.4.5 and Gensim 4.0.1. Please also install the evaluation tool DISCODOP as defined in https://github.com/andreasvc/disco-dop. Additionally, you can install continuous parsers such as [Kitaev et al., (2019)](https://github.com/nikitakit/self-attentive-parser) and [Yang and Deng, (2020)](https://github.com/princeton-vl/attach-juxtapose-parser) or use your own parser. 

## Pre-processing Data
First, please go to the experiments folder:

       cd experiments/
       
Given training, development and test discontinuous splits (``discbracket`` format) from DPTB, NEGRA or TIGER treebanks, move them to the folder ``reordering/data_discbracket`` and run the following command to transform them into continuous variants (``bracket`` format) that will be used for training the continuous parser.

      discodop treetransforms reordering/data_discbracket/<ptb|negra|tiger>_<train|dev>.discbracket reordering/input_parser/<ptb|negra|tiger>_<train|dev>.bracket --inputfmt=discbracket --outputfmt=bracket 

Please note that discontinuous test splits must be named as ``<ptb|negra|tiger>_test.discbracket`` so that they can be used for the final evaluation.


## Experiments
### Using pre-generated CCAs
First, please go to the experiments folder:
    
    cd experiments/

Then, copy the pre-generated CCAs provided in folder ``reordering/pregenerated_ccas`` as follows:

      cp reordering/pregenerated_ccas/<ptb|negra|tiger>_test.cca.bracket reordering/input_parser/
      cp reordering/pregenerated_ccas/<ptb|negra|tiger>_test.cca.pred reordering/predicted_cca/

Now, train a continuous parser with the continuous versions (``bracket`` format) of the original training and development treebanks located in folder ``reordering/input_parser/``, and, after that, use files ``reordering/input_parser/<ptb|negra|tiger>_test.cca.bracket`` for testing, saving the output in folder ``reordering/output_parser/`` with extension ``<output_name>.bracket.predicted``.


Finally, run the next script for recovering the original sentence order and evaluating the resulting trees in ``discbracket`` format:

	 ./reordering/eval.sh <output_name> <ptb|negra|tiger>


As an alternative, you can modify script ``scripts/test_cca.sh`` with the specific command to run your own parser (as an example, we included how to run the Kitaev et al., (2019)'s parser), and then just execute:

    ./scripts/test_cca.sh <output_name> <ptb|negra|tiger>


### Training your own pointer model for generating new CCAs
Please go to the experiments folder:

       cd experiments/

First, gold CCAs must be obtained from discontinuous treebanks in ``discbracket`` format and represented into the CoNLL format internally used by the pointer. This can be done by running this command:

       python reordering/discbr_to_conll.py < reordering/data_discbracket/<ptb|negra|tiger>_<train|dev|test>.discbracket > reordering/input_pointer/<ptb|negra|tiger>_<train|dev|test>.cca.conllx

Then, to train the pointer, just include regular and contextualized pre-trained word embeddings (BERT-based embeddings can be sent upon request) in folder ``embs/``, and run:

    ./scripts/<ptb|negra|tiger>.sh <model_name>

and, to test an already-trained model, just run:

    ./scripts/test_<ptb|negra|tiger>.sh <model_name>

Finally, to obtain the CCAs generated by the pointer, execute:

	 ./reordering/get_cca_from_conll.sh <model_name> <ptb|negra|tiger>

This command will directly create test files ``reordering/input_parser/<ptb|negra|tiger>_test.cca.bracket`` and ``reordering/predicted_cca/<ptb|negra|tiger>_test.cca.pred`` necesary for testing a previously-trained continuous parser. Therefore, you can skip the first step described in the previous section and directly run the continuous parser and, after that, evaluate its performance with the script ``./reordering/eval.sh``.


### Citation



### Acknowledgments

We acknowledge the European Research Council (ERC), which has funded this research under the European Union’s Horizon 2020 research and innovation programme (FASTPARSE, grant agreement No 714150), MINECO (ANSWER-ASAP, TIN2017-85160-C2- 1-R), Xunta de Galicia (ED431C 2020/11), and Centro de Investigaci\'on de Galicia ``CITIC'', funded by Xunta de Galicia and the European Union (ERDF - Galicia 2014-2020 Program), by grant ED431G 2019/01.


