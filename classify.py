from readfile import readData,readLabel
from sklearn.ensemble import GradientBoostingClassifier
# from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split


datafile = './Zhengsorted/Filtered_DownSampled_SortedPBMC_data.csv'
labelfile = './Zhengsorted/Labels.csv'

X = readData(datafile)
y = readLabel(labelfile)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state=42)

# clf = RandomForestClassifier(random_state=0)
clf = GradientBoostingClassifier(random_state=0)
clf.fit(X_train, y_train)
test_pred = clf.predict(X_test)
print(accuracy_score(y_test, test_pred))

