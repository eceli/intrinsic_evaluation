#!/usr/bin/env bash
#
#
echo "Prueba Base"
echo ""

PCFG="PCFG_nonconflation.py"
CASE=nco
CORPUS=nonconflation.txt
SAVE_FILE=nco

echo "0-Genero corpus"
echo "python PCFG/$PCFG"
python PCFG/$PCFG
echo "mv $CORPUS $CASE/"
mv $CORPUS $CASE/

PRE=sg-
EXT=.vec
echo "1-SkipGram"
echo "Generando el vector de sg"
echo "$ word2vec-master/word2vec -train $CASE/$CORPUS -output $CASE/$PRE$SAVE_FILE$EXT -cbow 0 -binary 0 -min-count 1"
word2vec-master/word2vec -train $CASE/$CORPUS -output $CASE/$PRE$SAVE_FILE$EXT -cbow 0 -binary 0 -min-count 1
echo "Generando los archivos de train y test de sg"
echo "$ python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT"
python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT
echo "Entrenando y prediciendo sg"
echo "$ liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model"
liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.out
echo "$ liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2"
liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train  $CASE/$PRE$SAVE_FILE$EXT.train.models2
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Test con Gensim liblinear"
echo "$ python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test"
python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test



echo "========================================================================================"
echo ""
PRE=cb-
EXT=.vec
echo "2-CBow"
echo "Generando el vector de cbow"
echo "$ word2vec-master/word2vec -train $CASE/$CORPUS -output $CASE/$PRE$SAVE_FILE$EXT -cbow 1 -binary 0 -min-count 1"
word2vec-master/word2vec -train $CASE/$CORPUS -output $CASE/$PRE$SAVE_FILE$EXT -cbow 1 -binary 0  -min-count 1
echo "Generando los archivos de train y test de cbow"
echo "$ python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT"
python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT
echo "Entrenando y prediciendo cbow"
echo "$ liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model"
liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.out
echo "s -2"
echo "$ liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train  $CASE/$PRE$SAVE_FILE$EXT.train.models2"
liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train  $CASE/$PRE$SAVE_FILE$EXT.train.models2
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Test con Gensim liblinear"
echo "$ python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test"
python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test

echo "========================================================================================"
echo ""
PRE=ft-
EXT=.vec
echo "3-FastText"
echo "Generando el vector de fastText"
echo "$ fastText-0.9.1/fasttext skipgram -input $CASE/$CORPUS -output $CASE/$PRE$SAVE_FILE -minCount 1"
fastText-0.9.1/fasttext skipgram -input $CASE/$CORPUS -output $CASE/$PRE$SAVE_FILE -minCount 1
echo "Generando los archivos de train y test de fastText"
echo "$ python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT"
python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT
echo "Entrenando y prediciendo fastText"
echo "$ liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model"
liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.out
echo "s -2"
echo "$ liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2"
liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train  $CASE/$PRE$SAVE_FILE$EXT.train.models2
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Test con Gensim liblinear"
echo "$ python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test"
python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test

echo "========================================================================================"
echo ""
PRE=gl-
EXT=.txt
VOCAB_FILE=vocab-
COOCCURRENCE_FILE=cooccurrence.bin
COOCCURRENCE_SHUF_FILE=cooccurrence.shuf.bin
BUILDDIR=GloVe-master/build
VERBOSE=2
MEMORY=4.0
VOCAB_MIN_COUNT=1
VECTOR_SIZE=50
MAX_ITER=15
WINDOW_SIZE=5
BINARY=2
NUM_THREADS=8
X_MAX=10
echo "4-GloVe-master"
echo "Generando el vector de GloVe"

echo "$ $BUILDDIR/vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CASE/$CORPUS > $CASE/$VOCAB_FILE$SAVE_FILE$EXT"
$BUILDDIR/vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CASE/$CORPUS > $CASE/$VOCAB_FILE$SAVE_FILE$EXT
echo "$ $BUILDDIR/cooccur -memory $MEMORY -vocab-file $CASE/$VOCAB_FILE$SAVE_FILE$EXT -verbose $VERBOSE -window-size $WINDOW_SIZE < $CASE/$CORPUS > $CASE/$SAVE_FILE$COOCCURRENCE_FILE"
$BUILDDIR/cooccur -memory $MEMORY -vocab-file $CASE/$VOCAB_FILE$SAVE_FILE$EXT -verbose $VERBOSE -window-size $WINDOW_SIZE < $CASE/$CORPUS > $CASE/$SAVE_FILE$COOCCURRENCE_FILE
echo "$ $BUILDDIR/shuffle -memory $MEMORY -verbose $VERBOSE < $CASE/$SAVE_FILE$COOCCURRENCE_FILE > $CASE/$SAVE_FILE$COOCCURRENCE_SHUF_FILE"
$BUILDDIR/shuffle -memory $MEMORY -verbose $VERBOSE < $CASE/$SAVE_FILE$COOCCURRENCE_FILE > $CASE/$SAVE_FILE$COOCCURRENCE_SHUF_FILE
echo "$ $BUILDDIR/glove -save-file $CASE/$PRE$SAVE_FILE -threads $NUM_THREADS -input-file $CASE/$SAVE_FILE$COOCCURRENCE_SHUF_FILE -x-max $X_MAX -iter $MAX_ITER -vector-size $VECTOR_SIZE -binary $BINARY -vocab-file $CASE/$VOCAB_FILE$SAVE_FILE$EXT -verbose $VERBOSE"
$BUILDDIR/glove -save-file $CASE/$PRE$SAVE_FILE -threads $NUM_THREADS -input-file $CASE/$SAVE_FILE$COOCCURRENCE_SHUF_FILE -x-max $X_MAX -iter $MAX_ITER -vector-size $VECTOR_SIZE -binary $BINARY -vocab-file $CASE/$VOCAB_FILE$SAVE_FILE$EXT -verbose $VERBOSE -eta 0.0005
echo "Generando los archivos de train y test de GloVe"
echo "$ python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT"
python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT
echo "Entrenando y prediciendo GloVe"
echo "$ liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model"
liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.out
echo "-s 2"
echo "$ liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2"
liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Test con Gensim liblinear"
echo "$ python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test"
python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test

echo "========================================================================================"
echo ""
BUILDDIR=GloVe-1.2/build
echo "5-GloVe-1.2"
echo "Generando el vector de GloVe"

echo "$ $BUILDDIR/vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CASE/$CORPUS > $CASE/$VOCAB_FILE$SAVE_FILE$EXT"
$BUILDDIR/vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CASE/$CORPUS > $CASE/$VOCAB_FILE$SAVE_FILE$EXT
echo "$ $BUILDDIR/cooccur -memory $MEMORY -vocab-file $CASE/$VOCAB_FILE$SAVE_FILE$EXT -verbose $VERBOSE -window-size $WINDOW_SIZE < $CASE/$CORPUS > $CASE/$SAVE_FILE$COOCCURRENCE_FILE"
$BUILDDIR/cooccur -memory $MEMORY -vocab-file $CASE/$VOCAB_FILE$SAVE_FILE$EXT -verbose $VERBOSE -window-size $WINDOW_SIZE < $CASE/$CORPUS > $CASE/$SAVE_FILE$COOCCURRENCE_FILE
echo "$ $BUILDDIR/shuffle -memory $MEMORY -verbose $VERBOSE < $CASE/$SAVE_FILE$COOCCURRENCE_FILE > $CASE/$SAVE_FILE$COOCCURRENCE_SHUF_FILE"
$BUILDDIR/shuffle -memory $MEMORY -verbose $VERBOSE < $CASE/$SAVE_FILE$COOCCURRENCE_FILE > $CASE/$SAVE_FILE$COOCCURRENCE_SHUF_FILE
echo "$ $BUILDDIR/glove -save-file $CASE/$PRE$SAVE_FILE -threads $NUM_THREADS -input-file $CASE/$SAVE_FILE$COOCCURRENCE_SHUF_FILE -x-max $X_MAX -iter $MAX_ITER -vector-size $VECTOR_SIZE -binary $BINARY -vocab-file $CASE/$VOCAB_FILE$SAVE_FILE$EXT -verbose $VERBOSE"
$BUILDDIR/glove -save-file $CASE/$PRE$SAVE_FILE -threads $NUM_THREADS -input-file $CASE/$SAVE_FILE$COOCCURRENCE_SHUF_FILE -x-max $X_MAX -iter $MAX_ITER -vector-size $VECTOR_SIZE -binary $BINARY -vocab-file $CASE/$VOCAB_FILE$SAVE_FILE$EXT -verbose $VERBOSE -eta 0.0005
echo "Generando los archivos de train y test de GloVe"
echo "$ python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT"
python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT
echo "Entrenando y prediciendo GloVe"
echo "$ liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model"
liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.out
echo "-s 2"
echo "$ liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2"
liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Test con Gensim liblinear"
echo "$ python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test"
python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test



echo "========================================================================================"
echo ""
echo "Entrenando en Gensim"
echo "$ python vec2libsmv/gs_w2vFT.py -c $CORPUS -b $CASE"
python vec2libsmv/gs_w2vFT.py -c $CORPUS -b $CASE

PRE=gSG_
EXT=.vec
echo "6-Gensim skipngram"
echo "Generando los archivos de train y test de sg"
echo "$ python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT"
python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT
echo "Entrenando y prediciendo sg"
echo "$ liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model"
liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.out
echo "-s 2"
echo "$ liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2"
liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Test con Gensim liblinear"
echo "$ python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test"
python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test

echo "========================================================================================"
echo ""
PRE=gCB_
EXT=.vec
echo "7-Gensim Cbow"
echo "Generando los archivos de train y test de sg"
echo "$ python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT"
python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT
echo "Entrenando y prediciendo sg"
echo "$ liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model"
liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.out
echo "-s 2"
echo "$ liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2"
liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Test con Gensim liblinear"
echo "$ python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test"
python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test


echo "========================================================================================"
echo ""
PRE=gFT_
EXT=.vec
echo "8-Gensim FastText"
echo "Generando los archivos de train y test de sg"
echo "$ python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT"
python vec2libsmv/vec2libsmv-$CASE.py -d $CASE/$PRE$SAVE_FILE$EXT
echo "Entrenando y prediciendo sg"
echo "$ liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model"
liblinear-2.30/train $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.model
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.out
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.out
echo "-s 2"
echo "$ liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2"
liblinear-2.30/train -s 2 $CASE/$PRE$SAVE_FILE$EXT.train $CASE/$PRE$SAVE_FILE$EXT.train.models2
echo "$ liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.models2 $CASE/$PRE$SAVE_FILE$EXT.outs2"
liblinear-2.30/predict $CASE/$PRE$SAVE_FILE$EXT.test $CASE/$PRE$SAVE_FILE$EXT.train.model $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Salida del clasificador"
cat $CASE/$PRE$SAVE_FILE$EXT.outs2
echo "Test con Gensim liblinear"
echo "$ python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test"
python vec2libsmv/gsLibSVC.py -r $CASE/$PRE$SAVE_FILE$EXT.train -t $CASE/$PRE$SAVE_FILE$EXT.test
