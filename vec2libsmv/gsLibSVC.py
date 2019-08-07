import argparse

from sklearn.svm import LinearSVC
from sklearn.datasets import load_svmlight_file
#X, y = make_classification(n_features=4, random_state=0)

parser = argparse.ArgumentParser(description='libsvc')
parser.add_argument(
    '--train',
    '-r',
    dest='train',
    action='store',
    required=True,
    help='train'
)

parser.add_argument(
    '--test',
    '-t',
    dest='test',
    action='store',
    required=True,
    help='test'
)
args = parser.parse_args()

archivo_train = args.train #"nco/gSG_nco.vec.train"
archivo_test = args.test #"nco/gSG_nco.vec.test"


X, y = load_svmlight_file(archivo_train)
tX, ty = load_svmlight_file(archivo_test)

print ("l2")
clf = LinearSVC()
clf.fit(X, y)  
#print(clf.coef_)
#print(clf.intercept_)
print(clf.predict(tX))
print(clf.score(tX,ty))

print ("l1")
clf = LinearSVC(penalty='l1', dual=False)
clf.fit(X, y)  
#print(clf.coef_)
#print(clf.intercept_)
print(clf.predict(tX))
print(clf.score(tX,ty))
