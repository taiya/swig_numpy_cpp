Python - NumPy - SWIG - C++  
==============

The smallest self contained example on how to interface numpy python matixes to c++ using swig.

- 1) How to modify an existing numpy matrix in C++
- 2) How to allocate/create a numpy matrix in the C++ backend (with auto-managed memory)  

# Compiling (OSX with native Python framework)

    swig -python -c++ -o generated.cpp mymodule.i
    g++ -I/System/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7 -I/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/numpy/core/include -c generated.cpp
    g++ -lpython -dynamiclib generated.o -o _mymodule.so
    rm -f generated*

# Content of runme.py
    #!/usr/bin/python
    import numpy;
    import mymodule;
    
    #--- Create a numpy array
    mat = numpy.array([[1, 0, 0],
                       [0, 1, 0],
                       [0, 0, 1]],
                       numpy.double)
    
    #--- Attempt to modify it
    print "matrix before\n",mat,"\n";
    mymodule.modify_numpy_matrix(mat);
    print "matrix after\n",mat,"\n";
    
    #--- Create a managed NumPy matrix on the C++ side
    mat = mymodule.allocate_numpy_matrix();
    print "matrix created in C++\n",mat,"\n";

# Example output

    ./runme.py
    matrix before
    [[ 1.  0.  0.]
     [ 0.  1.  0.]
     [ 0.  0.  1.]] 

    matrix after
    [[ 1.  4.  7.]
     [ 2.  5.  8.]
     [ 3.  6.  9.]] 

    matrix created in C++
    [[ 3.14  3.14  3.14  3.14  3.14  3.14  3.14  3.14  3.14  3.14]
     [ 3.14  3.14  3.14  3.14  3.14  3.14  3.14  3.14  3.14  3.14]
     [ 3.14  3.14  3.14  3.14  3.14  3.14  3.14  3.14  3.14  3.14]] 