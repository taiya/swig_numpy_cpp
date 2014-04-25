#--- OSX system python (used by /usr/bin/python)
PYTHON=/System/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7
NUMPY=/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/numpy/core/include

#--- Homebrew python (/usr/local/bin/python)
# PYTHON=/usr/local/Cellar/python/2.7.6/Frameworks/Python.framework/Versions/2.7/include/python2.7
# NUMPY=/usr/local/lib/python2.7/site-packages/numpy/core/include

all:
	swig -python -c++ -o generated.cpp mymodule.i
	g++ -I$(PYTHON) -I$(NUMPY) -c generated.cpp
	g++ -lpython -dynamiclib generated.o -o _mymodule.so
	rm -f generated*
	./runme.py
	
clean:
	rm -f mymodule.py mymodule.cpp mymodule.pyc _mymodule.so