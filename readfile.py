import pandas as pd
import numpy as np

def readData(filename):
    df = pd.read_csv(filename)
    data = df.to_numpy()
    cells = data[:,0]
    X = data[:,1:]
    return X


def readLabel(filename):
    df = pd.read_csv(filename)
    y = df.to_numpy()
    return y



